import UIKit
import Alamofire

class MovieVC: UIViewController {
    
    var searchText = UILabel()
    var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var segControl = CustomSegmentControl()
    var searchTextField = UITextField()
    var filterGenraiButton = UIButton()
    var moviesInfo: [MovieInfoResult] = []
    var findMovies: [MovieInfoResult] = []
    private var searchQuery: String = ""
    // Останній завантажений номер сторінки
    private var lastLoadedPage: Int = 1
    // Максимальна кількість сторінок
    private let maxPages: Int = 499
    var timer: Timer?
    var genre_ids: [Int]? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
        fetchMoviesInfo(numOfPage: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        addSubViews()
        configSearchTextField()
        configFilterButton()
        setConstraints()
        configChildElements()
        self.view.backgroundColor = .darkBlue
        segControl.backgroundColor = .darkBlue
        searchTextField.delegate = self
        segControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setConstraints()
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        if segControl.selectedSegmentIndex == 0 {
            if genre_ids != nil {
                fetchMoviesInfoWithGenres(genre_id: genre_ids!,onClearArray: true, numOfPage: 1,isComingSoon: false)
            } else {
                fetchMoviesInfo(numOfPage: 1, onClearArray: true)
            }
            let indexPath = IndexPath(item: 0, section: 0)
            movieCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            lastLoadedPage = 1
            searchTextField.text = ""
        } else if segControl.selectedSegmentIndex == 1 {
            if genre_ids != nil {
                fetchMoviesInfoWithGenres(genre_id: genre_ids!,onClearArray: true, numOfPage: 1,isComingSoon: true)
            } else {
                fetchMoviesInfoComingSoon(numOfPage: 1, onClearArray: true)
            }
            let indexPath = IndexPath(item: 0, section: 0)
            movieCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            lastLoadedPage = 1
            searchTextField.text = ""
        }
    }
    private func addSubViews() {
        [searchText, segControl,searchTextField,movieCollectionView, imageView, filterGenraiButton].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    private func configSegControl() {
        let font = UIFont(name: "Montserrat-Medium", size: 18)
        let normalAttributes: [NSAttributedString.Key: Any] = [.font: font!, .foregroundColor: UIColor.customColorGrayColor!]
        let selectedAttributes: [NSAttributedString.Key: Any] = [.font: font!, .foregroundColor: UIColor.white]
        
        segControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segControl.insertSegment(withTitle: "Now Showing", at: 0, animated: false)
        segControl.insertSegment(withTitle: "Coming Soon", at: 1, animated: false)
        segControl.selectedSegmentIndex = 0
        
        segControl.layer.borderWidth = 2.0
        segControl.layer.borderColor = UIColor.blueGray.cgColor
        
        segControl.selectedSegmentTintColor = .red
        
    }
    
    private func configLabel() {
        searchText.text = "Star Movie"
        searchText.font = UIFont(name: "Montserrat-Medium", size: 24)
        searchText.textColor = .white
    }
    @objc private func filterGenraiButtonTapped() {
        let genreVC = GenreVC()
        genreVC.movievc = self
        genreVC.genres = genre_ids ?? []
        navigationController?.pushViewController(genreVC, animated: true)
        
    }
    private func configFilterButton() {
        if let image = UIImage(named: "ImageFilterGenrai") {
            filterGenraiButton.setImage(image, for: .normal)
        }
        filterGenraiButton.addTarget(self, action: #selector(filterGenraiButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func handleTap() {
        // Скрываем клавиатуру
        view.endEditing(true)
    }
    
    let imageView: UIImageView = {
        let searchImage = UIImage(systemName: "magnifyingglass") // Картинка лупи
        
        return UIImageView(image: searchImage)
    } ()
    
    private func configSearchTextField() {
        searchTextField.delegate = self
        searchTextField.backgroundColor = .black
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = 20
        searchTextField.clipsToBounds = true
        searchTextField.textColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        
        let placeholderText = "Search"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: searchTextField.font ?? UIFont.systemFont(ofSize: 17)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        searchTextField.textAlignment = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: 105).isActive = true
        imageView.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
    }
    
    @objc private func searchMovies() {
        searchQuery = searchTextField.text ?? ""
        searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        genre_ids = []
        if(searchQuery != "") {
            lastLoadedPage = 1
            fetchMoviesInfoWithSearch(numOfPage: lastLoadedPage, onClearArray: true)
        } else {
            switch (segControl.selectedSegmentIndex)
            {
            case 0:
                fetchMoviesInfo(numOfPage: 1, onClearArray: true)
                
            case 1: fetchMoviesInfoComingSoon(numOfPage: 1, onClearArray: true)
            default:
                break;
            }
        }
    }
    
    private func configMovieCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        movieCollectionView.backgroundColor = .darkBlue
    }
    
    private func configChildElements() {
        configSegControl()
        configLabel()
        configMovieCollectionView()
    }
    
    ///позиціювання елементів на view
    private func setConstraints() {
        segControl.setConstraintCustomSegmControl(in: self)
        [searchText,movieCollectionView,searchTextField, imageView,filterGenraiButton].forEach
        { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            filterGenraiButton.topAnchor.constraint(equalTo: self.searchText.bottomAnchor, constant: 20),
            filterGenraiButton.leadingAnchor.constraint(equalTo: self.searchTextField.trailingAnchor, constant: 10),
            filterGenraiButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            filterGenraiButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            searchText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            searchText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchText.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.searchText.bottomAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            searchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        movieCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        movieCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        movieCollectionView.topAnchor.constraint(equalTo: segControl.bottomAnchor, constant: 30).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: 124),
            imageView.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: -10)
        ])
    }
}


extension MovieVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell {
            cell.configCell(moviesInfo[indexPath.row])
            
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filmInfo = moviesInfo[indexPath.row]
        let page = PageOfMovieVC(filmInfo: filmInfo)
        navigationController?.show(page, sender: nil)
        //    navigationController?.pushViewController(page, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (movieCollectionView.frame.width / 2) - 4, height: 380)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.size.height
        let selectedSegmentIndex = segControl.selectedSegmentIndex
        
        if offsetY > contentHeight - visibleHeight && lastLoadedPage < maxPages {
            let nextPage = lastLoadedPage + 1
            
            if(!(searchTextField.text?.isEmpty ?? true)) {
                fetchMoviesInfoWithSearch(numOfPage: nextPage)
            } else {
                if genre_ids != nil {
                    if selectedSegmentIndex == 0 {
                        fetchMoviesInfoWithGenres(genre_id: genre_ids!,numOfPage: nextPage)
                    } else {
                        fetchMoviesInfoWithGenres(genre_id: genre_ids!,numOfPage: nextPage,isComingSoon: true)
                    }
                }else {
                    if selectedSegmentIndex == 0 {
                        fetchMoviesInfo(numOfPage: nextPage)
                    } else if selectedSegmentIndex == 1 {
                        fetchMoviesInfoComingSoon(numOfPage: nextPage)
                    }
                }
            }
            lastLoadedPage = nextPage
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            imageView.isHidden = true
        } else {
            imageView.isHidden = false
        }
        
        // Скасовуємо попередній таймер, якщо він вже існує
        timer?.invalidate()
        
        //Запускаємо новий таймер з затримкою 2 секунд
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.searchMovies()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder() // Приховує клавіатуру
        return true
    }
    private func fetchMoviesInfoWithSearch(numOfPage: Int, onClearArray: Bool = false) {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=b8541e6f0d360a89fe91881fcb73d439&query=\(searchQuery)&page=\(numOfPage)"
        
        
        AF.request(urlString).responseDecodable(of: MoviesInfo.self) { response in
            switch response.result {
            case .success(let movieInfo):
                if let results = movieInfo.results {
                    if onClearArray {
                        self.moviesInfo = []
                    }
                    
                    self.moviesInfo += results
                    self.movieCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    /// Заповнює масив moviesInfo інформацію про фильм
    private func fetchMoviesInfo(numOfPage: Int, onClearArray: Bool = false) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=b8541e6f0d360a89fe91881fcb73d439&page=\(numOfPage)"
        
        AF.request(urlString).responseDecodable(of: MoviesInfo.self) { response in
            switch response.result {
            case .success(let movieInfo):
                if let results = movieInfo.results {
                    if onClearArray {
                        self.moviesInfo = []
                    }
                    self.moviesInfo += results
                    self.movieCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    public func fetchMoviesInfoWithGenres(genre_id: [Int], onClearArray: Bool = false, numOfPage:Int = 1, isComingSoon:Bool = false) {
        var genres = ""
        var urlString = "https://api.themoviedb.org/3/discover/movie?api_key=f5fc273d435f10ca0130435f60524443&page=\(numOfPage)&with_genres="
        genre_id.forEach {
            genres += ",\($0)"
        }
        urlString += genres
        if isComingSoon {
            urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=b8541e6f0d360a89fe91881fcb73d439&page=\(numOfPage)"
        }
        AF.request(urlString).responseDecodable(of: MoviesInfo.self) { response in
            switch response.result {
            case .success(let movieInfo):
                if let results = movieInfo.results {
                    if onClearArray {
                        self.moviesInfo = []
                    }
                    self.moviesInfo += results
                    var bufer: [MovieInfoResult] = []
                    self.moviesInfo.forEach {
                        if $0.genre_ids?.contains(genre_id) ?? false {
                            bufer.append($0)
                        }
                    }
                    bufer.forEach {
                        print($0)
                    }
                    self.movieCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    private func fetchMoviesInfoComingSoon(numOfPage: Int, onClearArray: Bool = false) {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=b8541e6f0d360a89fe91881fcb73d439&page=\(numOfPage)"
        
        AF.request(urlString).responseDecodable(of: MoviesInfo.self) { response in
            switch response.result {
            case .success(let movieInfo):
                if let results = movieInfo.results {
                    if onClearArray {
                        self.moviesInfo = []
                    }
                    self.moviesInfo += results
                    self.movieCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


