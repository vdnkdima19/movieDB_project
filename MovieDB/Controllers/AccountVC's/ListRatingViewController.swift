import UIKit

class ListRatingViewController: UIViewController {
    var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var listOfMovieArr: [MovieInfoResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfMovieArr = FavoriteMovies.shared.moviesArr
        self.setTitleNavBar(text: "List of movies")
        self.view.backgroundColor = .darkBlue
        addSubViews()
        setConstraints()
        configMovieCollectionView()
    }
    
    private func addSubViews() {
        [movieCollectionView].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        [movieCollectionView].forEach
        { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            movieCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            movieCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func configMovieCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        movieCollectionView.backgroundColor = .darkBlue
    }
}
extension ListRatingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMovieArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell {
        cell.configCell(listOfMovieArr[indexPath.row])
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (movieCollectionView.frame.width / 2) - 4, height: 380)
    }
}
