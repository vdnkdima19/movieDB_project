import UIKit
import Alamofire
import RealmSwift
import YouTubeiOSPlayerHelper

class PageOfMovieVC: UIViewController, PageOfMovieVCProtocol {
    var scrollView = UIScrollView()
    
    var backImage = UIImageView()
    var shareButton = UIButton()
    var posterImageView = UIImageView()
    
    var titleOfMovieLabel = UILabel()
    
    var releaseAndRatingMovieLabel = UILabel()
    var genreOfMovie = UILabel()
    var ratingAndStarsStackView = UIStackView()
    
    var descriptionOfMovieLabel = UILabel()
    var descriptionTextOfMovieLabel = UILabel()
    
    var castAndCrewStackView = UIStackView()
    var castAndCrewTableView = UITableView()
    
    var photosStackView = UIStackView()
    
    var photosScrollView = UIScrollView()
    var firstPhoto = UIImageView()
    var secondPhoto = UIImageView()
    var theerdPhoto = UIImageView()
    var fourPhoto = UIImageView()
    var fivePhoto = UIImageView()
    
    var videosStackView = UIStackView()
    var videosScrollView = UIScrollView()
    
    var firstVideo = YTPlayerView()
    var secondVideo = YTPlayerView()
    var theerdVideo = YTPlayerView()
    var fourVideo = YTPlayerView()
    var fiveVideo = YTPlayerView()
    
    var filmInfo: MovieInfoResult?
    
    var reviewStackView = UIStackView()
    var reviewTableView = UITableView()
    
    let apiKey = "f5fc273d435f10ca0130435f60524443"
    
    var reviews:[ReviewResult] = []
    
    
    var cast: [Cast] = []
    var backdrops: [Backdrops] = []
    var videos: [VideoResults] = []
    
    init(filmInfo: MovieInfoResult) {
        super.init(nibName: nil, bundle: nil)
        self.filmInfo = filmInfo
        self.photos = [firstPhoto, secondPhoto, theerdPhoto, fourPhoto, fivePhoto]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.barTintColor = UIColor.darkBlue
        SellectedMoview.moview = filmInfo
        
        addSubviews()
        
        castAndCrewTableView.isScrollEnabled = false
        setTextColorAndFontsOfLabels()
        setBackImage()
        setShareButton()
        setPoster()
        setTextOfTitleOfMovieLabel()
        setBackgrounColorOfAllScrollView()
        setBackgroundColorOfAllTableView()
        
        configAllStackViews()
        configTableViews()
        setDataFromTMDB()
        
        setReleaseAndRatingMovie()
        setGenreOfMovie()
        setDescriptionText()
        setVoteAverageStars()
        scrollView.showsVerticalScrollIndicator = false
        photosScrollView.showsHorizontalScrollIndicator = false
        videosScrollView.showsHorizontalScrollIndicator = false
    }
    
    private func setDataFromTMDB() {
        fetchMovieFrames(movieId: filmInfo?.id ?? 0)
        fetchCast(movieID: filmInfo?.id ?? 0)
        fetchVideos(movieId: filmInfo?.id ?? 0)
        fetchReviews(movieId: filmInfo?.id ?? 0)
    }
    
    private func configTableViews() {
        registerCellOfTableViews()
        
        castAndCrewTableView.delegate = self
        castAndCrewTableView.dataSource = self
        castAndCrewTableView.separatorStyle = .none
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.separatorStyle = .none
    }
    
    private func configAllStackViews() {
        configCastAndCrewStackView()
        configPhotosStackView()
        configVideoStackView()
        configReviewStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
        setSizeOfScrollView()
        setConstraints()
    }
    
    public func addSubviews() {
        self.view.addSubview(scrollView)
        
        [titleOfMovieLabel, backImage, posterImageView, releaseAndRatingMovieLabel, genreOfMovie, ratingAndStarsStackView, descriptionOfMovieLabel,descriptionTextOfMovieLabel,castAndCrewStackView,castAndCrewTableView,photosStackView, photosScrollView,videosStackView,videosScrollView,reviewStackView, reviewTableView,shareButton].forEach {
            scrollView.addSubview($0)
        }
        
        [firstPhoto,secondPhoto,theerdPhoto,fourPhoto,fivePhoto].forEach {
            photosScrollView.addSubview($0)
        }
        [firstVideo, secondVideo, theerdVideo, fourVideo, fiveVideo].forEach {
            videosScrollView.addSubview($0)
        }
        
    }
    
    public func setTextColorAndFontsOfLabels() {
        titleOfMovieLabel.textColor = .white
        titleOfMovieLabel.font = UIFont(name: "Montserrat-Medium", size: 20)
        [releaseAndRatingMovieLabel, genreOfMovie,descriptionTextOfMovieLabel].forEach {
            $0.font = UIFont(name: "Montserrat-Medium", size: 13)
            $0.textColor = .customColorGrayColor
        }
        descriptionOfMovieLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        descriptionOfMovieLabel.textColor = .white
    }
    
    public func setBackImage() {
        if let backImage = filmInfo?.backdrop_path {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + backImage)!
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    let blurFilter = CIFilter(name: "CIGaussianBlur")
                    blurFilter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)
                    blurFilter?.setValue(4, forKey: kCIInputRadiusKey)
                    if let outputImage = blurFilter?.outputImage {
                        let context = CIContext(options: nil)
                        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                            let blurredImage = UIImage(cgImage: cgImage)
                            self?.backImage.image = blurredImage
                        }
                    }
                }
            }.resume()
        }
        
        backImage.contentMode = .scaleAspectFill
        backImage.clipsToBounds = true
    }
    
    public func setShareButton() {
        if let image = UIImage(named: "imageOfShare") {
            shareButton.setImage(image, for: .normal)
        }
        shareButton.addTarget(self, action: #selector(shareMovie), for: .touchUpInside)

    }
    
    @objc public func shareMovie() {
        guard let filmInfo = filmInfo,
              let filmTitle = filmInfo.title,
              let filmID = filmInfo.id else {
            return
        }
        
        let filmURL = "https://www.themoviedb.org/movie/\(filmID)"

        let activityViewController = UIActivityViewController(activityItems: [filmTitle, URL(string: filmURL)!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    
    
    public func setPoster() {
        if let posterPath = filmInfo?.poster_path {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)!
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self?.viewFullPoster))
                    self?.posterImageView.isUserInteractionEnabled = true
                    self?.posterImageView.addGestureRecognizer(tapGesture)
                }
            }.resume()
        }
    }

    @objc private func viewFullPoster() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        let fullPoster = FullscreenImageViewController(image: posterImageView.image)
        navigationController?.pushViewController(fullPoster, animated: true)
    }
    
    public func setBackgrounColorOfAllScrollView() {
        [scrollView, photosScrollView, videosScrollView].forEach {
            $0.backgroundColor = .darkBlue
        }
    }
    public func setBackgroundColorOfAllTableView() {
        [castAndCrewTableView, reviewTableView].forEach {
            $0.backgroundColor = .darkBlue
        }
    }
    public func registerCellOfTableViews() {
        castAndCrewTableView.register(ActorCell.self, forCellReuseIdentifier: "ActorCell")
        reviewTableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
    }
    public func setTextOfTitleOfMovieLabel() {
        titleOfMovieLabel.text = filmInfo?.title ?? ""
        titleOfMovieLabel.textAlignment = .center
        titleOfMovieLabel.lineBreakMode = .byTruncatingTail
           titleOfMovieLabel.adjustsFontSizeToFitWidth = true
           titleOfMovieLabel.minimumScaleFactor = 0.5
           titleOfMovieLabel.numberOfLines = 0
           titleOfMovieLabel.sizeToFit()
    }
    public func setConstraints() {
        [titleOfMovieLabel, backImage,posterImageView,releaseAndRatingMovieLabel, genreOfMovie,ratingAndStarsStackView,descriptionOfMovieLabel,descriptionTextOfMovieLabel,castAndCrewStackView,castAndCrewTableView, photosStackView, photosScrollView,firstPhoto,secondPhoto,theerdPhoto,fourPhoto,fivePhoto, videosStackView, videosScrollView, firstVideo, secondVideo, theerdVideo, fourVideo, fiveVideo,reviewStackView, reviewTableView, shareButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        NSLayoutConstraint.activate([
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: -60),
            backImage.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            backImage.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            backImage.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            shareButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 72),
            posterImageView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 115),
            posterImageView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -115),
            posterImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            titleOfMovieLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 32),
            titleOfMovieLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleOfMovieLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            titleOfMovieLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16),
         //   titleOfMovieLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate ([
            releaseAndRatingMovieLabel.topAnchor.constraint(equalTo: self.titleOfMovieLabel.bottomAnchor, constant: 16),
            releaseAndRatingMovieLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            releaseAndRatingMovieLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate ([
            genreOfMovie.topAnchor.constraint(equalTo: self.releaseAndRatingMovieLabel.bottomAnchor, constant: 8),
            genreOfMovie.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            genreOfMovie.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            ratingAndStarsStackView.topAnchor.constraint(equalTo: self.genreOfMovie.bottomAnchor, constant: 29),
            ratingAndStarsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            ratingAndStarsStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionOfMovieLabel.topAnchor.constraint(equalTo: self.ratingAndStarsStackView.bottomAnchor, constant: 30),
            descriptionOfMovieLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 18),
            descriptionOfMovieLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextOfMovieLabel.topAnchor.constraint(equalTo: self.descriptionOfMovieLabel.bottomAnchor, constant: 10),
            descriptionTextOfMovieLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 18),
            descriptionTextOfMovieLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -18),
            descriptionTextOfMovieLabel.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            castAndCrewStackView.topAnchor.constraint(equalTo: self.descriptionTextOfMovieLabel.bottomAnchor, constant: 15),
            castAndCrewStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 18),
            castAndCrewStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -18),
            castAndCrewStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            castAndCrewTableView.topAnchor.constraint(equalTo: self.castAndCrewStackView.bottomAnchor, constant: 10),
            castAndCrewTableView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            castAndCrewTableView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            castAndCrewTableView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        NSLayoutConstraint.activate([
            photosStackView.topAnchor.constraint(equalTo: self.castAndCrewTableView.bottomAnchor, constant: 30),
            photosStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 18),
            photosStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -18),
            photosStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            photosScrollView.topAnchor.constraint(equalTo: self.photosStackView.topAnchor,constant: 50),
            photosScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosScrollView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            firstPhoto.topAnchor.constraint(equalTo: self.photosScrollView.topAnchor,constant: 10),
            firstPhoto.leadingAnchor.constraint(equalTo: self.photosScrollView.leadingAnchor, constant: 25),
            firstPhoto.heightAnchor.constraint(equalToConstant: 230),
            firstPhoto.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            secondPhoto.topAnchor.constraint(equalTo: self.photosScrollView.topAnchor,constant: 10),
            secondPhoto.leadingAnchor.constraint(equalTo: self.firstPhoto.trailingAnchor, constant: 10),
            secondPhoto.heightAnchor.constraint(equalToConstant: 230),
            secondPhoto.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            theerdPhoto.topAnchor.constraint(equalTo: self.photosScrollView.topAnchor,constant: 10),
            theerdPhoto.leadingAnchor.constraint(equalTo: self.secondPhoto.trailingAnchor, constant: 10),
            theerdPhoto.heightAnchor.constraint(equalToConstant: 230),
            theerdPhoto.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            fourPhoto.topAnchor.constraint(equalTo: self.photosScrollView.topAnchor,constant: 10),
            fourPhoto.leadingAnchor.constraint(equalTo: self.theerdPhoto.trailingAnchor, constant: 10),
            fourPhoto.heightAnchor.constraint(equalToConstant: 230),
            fourPhoto.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            fivePhoto.topAnchor.constraint(equalTo: self.photosScrollView.topAnchor,constant: 10),
            fivePhoto.leadingAnchor.constraint(equalTo: self.fourPhoto.trailingAnchor, constant: 10),
            fivePhoto.heightAnchor.constraint(equalToConstant: 230),
            fivePhoto.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            videosStackView.topAnchor.constraint(equalTo: self.photosScrollView.bottomAnchor,constant: 10),
            videosStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 18),
            videosStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -18),
            videosStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            videosScrollView.topAnchor.constraint(equalTo: self.videosStackView.topAnchor,constant: 50),
            videosScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            videosScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            videosScrollView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            firstVideo.topAnchor.constraint(equalTo: self.videosScrollView.topAnchor,constant: 10),
            firstVideo.leadingAnchor.constraint(equalTo: self.videosScrollView.leadingAnchor, constant: 25),
            firstVideo.heightAnchor.constraint(equalToConstant: 230),
            firstVideo.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            secondVideo.topAnchor.constraint(equalTo: self.videosScrollView.topAnchor,constant: 10),
            secondVideo.leadingAnchor.constraint(equalTo: self.firstVideo.trailingAnchor, constant: 10),
            secondVideo.heightAnchor.constraint(equalToConstant: 230),
            secondVideo.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            theerdVideo.topAnchor.constraint(equalTo: self.videosScrollView.topAnchor,constant: 10),
            theerdVideo.leadingAnchor.constraint(equalTo: self.secondVideo.trailingAnchor, constant: 10),
            theerdVideo.heightAnchor.constraint(equalToConstant: 230),
            theerdVideo.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            fourVideo.topAnchor.constraint(equalTo: self.videosScrollView.topAnchor,constant: 10),
            fourVideo.leadingAnchor.constraint(equalTo: self.theerdVideo.trailingAnchor, constant: 10),
            fourVideo.heightAnchor.constraint(equalToConstant: 230),
            fourVideo.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            fiveVideo.topAnchor.constraint(equalTo: self.videosScrollView.topAnchor,constant: 10),
            fiveVideo.leadingAnchor.constraint(equalTo: self.fourVideo.trailingAnchor, constant: 10),
            fiveVideo.heightAnchor.constraint(equalToConstant: 230),
            fiveVideo.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            reviewStackView.topAnchor.constraint(equalTo: self.videosScrollView.bottomAnchor, constant: 30),
            reviewStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 18),
            reviewStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -18),
            reviewStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            reviewTableView.topAnchor.constraint(equalTo: self.reviewStackView.bottomAnchor, constant: 10),
            reviewTableView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            reviewTableView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            reviewTableView.heightAnchor.constraint(equalToConstant: 5000)
        ])
        
    }
    public func setReleaseAndRatingMovie() {
        let releaseData = filmInfo?.release_date ?? ""
        if let adult = filmInfo?.adult{
            let ratingMovie = adult ? "R" : "G"
            releaseAndRatingMovieLabel.text = "\(releaseData) | \(ratingMovie)"
            
        }
    }
    
    public func setGenreOfMovie() {
        if let genreIds = filmInfo?.genre_ids, genreIds.count >= 3 {
            let firstThreeGenreIds = Array(genreIds.prefix(3))
            
            var genreIdStrings: [String] = []
            for genreId in firstThreeGenreIds {
                let genreIdString: String
                switch genreId {
                case 28:
                    genreIdString = "Action"
                case 12:
                    genreIdString = "Adventure"
                case 16:
                    genreIdString = "Animation"
                case 35:
                    genreIdString = "Comedy"
                case 80:
                    genreIdString = "Crime"
                case 99:
                    genreIdString = "Documentary"
                case 18:
                    genreIdString = "Drama"
                case 10751:
                    genreIdString = "Family"
                case 14:
                    genreIdString = "Fantasy"
                case 36:
                    genreIdString = "History"
                case 27:
                    genreIdString = "Horror"
                case 10402:
                    genreIdString = "Music"
                case 9648:
                    genreIdString = "Mystery"
                case 10749:
                    genreIdString = "Romance"
                case 878:
                    genreIdString = "Science Fiction"
                case 10770:
                    genreIdString = "TV Movie"
                case 53:
                    genreIdString = "Thriller"
                case 10752:
                    genreIdString = "War"
                case 37:
                    genreIdString = "Western"
                default:
                    genreIdString = "Unknown Genre"
                }
                genreIdStrings.append(genreIdString)
            }
            
            let genreLabelText = genreIdStrings.joined(separator: ", ")
            genreOfMovie.text = genreLabelText
            
        }
    }
    
    public func setDescriptionText() {
        descriptionOfMovieLabel.text = "Synopsis"
        descriptionTextOfMovieLabel.numberOfLines = 0
        descriptionTextOfMovieLabel.text = filmInfo?.overview ?? ""
    }
    
    public func setVoteAverageStars() {
        if (filmInfo?.vote_average) != nil {
            if let voteAverage = filmInfo?.vote_average {
                let ratingLabel = UILabel()
                ratingLabel.text = String("\(voteAverage / 2)/5")
                ratingLabel.font = UIFont(name: "Montserrat-Medium", size: 20)
                ratingLabel.textColor = .white
                ratingAndStarsStackView.addArrangedSubview(ratingLabel)
                configStarsStackView(Int(((voteAverage) / Double(2)).rounded()))
            }
        }
    }
    
    public func configStarsStackView(_ countOfElements: Int) {
        if countOfElements >= 0 && countOfElements <= 5 {
            ratingAndStarsStackView.distribution = .equalSpacing
            
            let filllStarImage = UIImage(systemName: "star.fill")
            let starImage = UIImage(systemName: "star")
            let starTintColor = UIColor(#colorLiteral(red: 1, green: 0.7529411765, blue: 0.2705882353, alpha: 1))
            
            for count in 0...4 {
                let starView = UIImageView(image: count < (countOfElements) ? filllStarImage : starImage)
                starView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                starView.tintColor = starTintColor
                
                if ratingAndStarsStackView.arrangedSubviews.count <= 5 {
                    ratingAndStarsStackView.addArrangedSubview(starView)
                }
            }
        }
    }
    public func configCastAndCrewStackView() {
        let textLabel = UILabel()
        textLabel.text = "Cast & Crew"
        textLabel.font = UIFont(name: "Montserrat-Medium", size: 18)
        textLabel.textColor = .white
        castAndCrewStackView.addArrangedSubview(textLabel)
        
        let viewAllButton = UIButton()
        viewAllButton.setTitle("View All", for: .normal)
        viewAllButton.setTitleColor(.systemTeal, for: .normal)
        castAndCrewStackView.addArrangedSubview(viewAllButton)
        
        viewAllButton.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
    }
    
    @objc private func viewAllButtonTapped() {
        let castAndCrewVC = CastAndCrewVC(movieID: filmInfo?.id ?? 0)
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(castAndCrewVC, animated: true)
    }
    
    public func configPhotosStackView() {
        let textPhotoLabel = UILabel()
        textPhotoLabel.text = "Photos"
        textPhotoLabel.font = UIFont(name: "Montserrat-Medium", size: 18)
        textPhotoLabel.textColor = .white
        photosStackView.addArrangedSubview(textPhotoLabel)
        
        let viewAllPhotosButton = UIButton()
        viewAllPhotosButton.setTitle("View All", for: .normal)
        viewAllPhotosButton.setTitleColor(.systemTeal, for: .normal)
        photosStackView.addArrangedSubview(viewAllPhotosButton)
        
        viewAllPhotosButton.addTarget(self, action: #selector(viewAllPhotoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func viewAllPhotoButtonTapped() {
        let movieframesvc = MovieFramesVC(movieID: filmInfo?.id ?? 0)
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(movieframesvc, animated: true)
    }
    
    public func configVideoStackView() {
        let textVideoLabel = UILabel()
        textVideoLabel.text = "Videos"
        textVideoLabel.font = UIFont(name: "Montserrat-Medium", size: 18)
        textVideoLabel.textColor = .white
        videosStackView.addArrangedSubview(textVideoLabel)
        
        let viewAllVideosButton = UIButton()
        viewAllVideosButton.setTitle("View All", for: .normal)
        viewAllVideosButton.setTitleColor(.systemTeal, for: .normal)
        videosStackView.addArrangedSubview(viewAllVideosButton)
        
        viewAllVideosButton.addTarget(self, action: #selector(viewAllVideoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func viewAllVideoButtonTapped() {
        let trailersvc = TrailersVC(movieID: filmInfo?.id ?? 0)
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(trailersvc, animated: true)
    }
    
    public func configReviewStackView() {
        let textReviewLabel = UILabel()
        textReviewLabel.text = "Review"
        textReviewLabel.font = UIFont(name: "Montserrat-Medium", size: 18)
        textReviewLabel.textColor = .white
        reviewStackView.addArrangedSubview(textReviewLabel)
        
        let viewAllReviewButton = UIButton()
        viewAllReviewButton.setTitle("View All", for: .normal)
        viewAllReviewButton.setTitleColor(.systemTeal, for: .normal)
        reviewStackView.addArrangedSubview(viewAllReviewButton)
        
        viewAllReviewButton.addTarget(self, action: #selector(viewAllReviewButtonTapped), for: .touchUpInside)
    }
    @objc private func viewAllReviewButtonTapped() {
        let reviewvc = ReviewsVC(reviews: reviews, filmName: filmInfo?.title ?? "")
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(reviewvc, animated: true)
    }
    
    public func setSizeOfScrollView() {
            let contentHeight = reviewTableView.contentSize.height
            let scrollViewContentHeight = reviewTableView.frame.origin.y + contentHeight
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollViewContentHeight)
    }
    
    let photoWidth: CGFloat = 300 // Змініть ширину кожної фотографії відповідно до своїх потреб
    var photos: [UIImageView] = []
    public func setSizeOfPhotosScroll(photosCount: Int) {
       var count = photosCount
       if(count > 5) { count = 5}

       let contentWidth = CGFloat(count) * photoWidth + CGFloat(count) * 20

       photos.forEach { photo in
           photosScrollView.addSubview(photo)
       }

       photosScrollView.contentSize = CGSize(width: contentWidth, height: photosScrollView.frame.height)
   }
    
    public func setSizeOfVideosScroll(videosCount: Int) {
        var count = videosCount
        if(count > 5) { count = 5}
            
        let scrollWitdth = CGFloat( count * Int(photoWidth) + (count * 20))
        videosScrollView.contentSize = CGSize(width: scrollWitdth, height: videosScrollView.frame.height)
    }
    
   public func fetchCast(movieID: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(apiKey)"
        AF.request(url).responseDecodable(of: Film.self) { response in
            switch response.result {
            case .success(let castResponse):
                if let cast = castResponse.cast {
                    self.cast = cast
                    self.castAndCrewTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    public func fetchMovieFrames(movieId: Int) {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/images?api_key=\(apiKey)"
        
        AF.request(urlString).responseDecodable(of: MovieFrames.self) { response in
            switch response.result {
            case .success(let imageResponse):
                self.backdrops = imageResponse.backdrops ?? []
                
                let backdropsCount = self.backdrops.count
                
                self.setSizeOfPhotosScroll(photosCount: backdropsCount)
                
                var i = 0
                while i < backdropsCount {
                    if i <= (self.photosScrollView.subviews.count - 1) {
                        if let photoView = self.photosScrollView.subviews[i] as? UIImageView {
                            let imageUrlString = "https://image.tmdb.org/t/p/w500" + (self.backdrops[i].filePath ?? "")
                            AF.request(imageUrlString).responseData { response in
                                switch response.result {
                                case .success(let imageData):
                                    if let image = UIImage(data: imageData) {
                                        photoView.image = image
                                    }
                                case .failure(let error):
                                    print("Error downloading image: \(error)")
                                }
                            }
                        }
                    }
                    i += 1
                }
            case .failure(let error):
                print("Error fetching movie frames: \(error)")
            }
        }
    }
    public func fetchVideos(movieId: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
        
        AF.request(urlString).responseDecodable(of: Video.self) { response in
            switch response.result {
            case .success(let videoResponse):
                guard let videoResults = videoResponse.results else {
                    return
                }
                
                self.setSizeOfVideosScroll(videosCount: videoResults.count)
                
                let videoCount = min(videoResults.count, self.videosScrollView.subviews.count)
                
                for i in 0..<videoCount {
                    if let videoView = self.videosScrollView.subviews[i] as? YTPlayerView {
                        let videoKey = videoResults[i].key ?? ""
                        videoView.load(withVideoId: videoKey)
                    }
                }
            case .failure(let error):
                print("Error fetching movie videos: \(error)")
            }
        }
    }

    public func fetchReviews(movieId: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(apiKey)"
        
        let realm = try! Realm()
        let comments = realm.objects(Comments.self).where( {
            $0.filmId == movieId && $0.status != 0 && $0.status != -1
        } )
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        comments.forEach {
            reviews.append(ReviewResult(author: $0.userName, content: $0.text, created_at: dateFormater.string(from: $0.date), raiting: $0.mark))
        }
        AF.request(urlString).responseDecodable(of: Review.self) { response in
            switch response.result {
            case .success(let review):
                if let results = review.results {
                    
                    results.forEach {
                        self.reviews.append($0)
                    }
                    self.reviewTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
extension UIImage {
    func applyBlurEffect() -> UIImage? {
        let context = CIContext(options: nil)
        guard let ciImage = CIImage(image: self) else { return nil }
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(10, forKey: kCIInputRadiusKey)
        
        guard let outputImage = filter?.outputImage,
              let cgImage = context.createCGImage(outputImage, from: ciImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
    }
}
extension PageOfMovieVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case castAndCrewTableView: do {
            if let cell = castAndCrewTableView.dequeueReusableCell(withIdentifier: "ActorCell", for: indexPath) as? ActorCell {
                let backgroundView = UIView()
                backgroundView.backgroundColor = .darkBlue
                cell.selectedBackgroundView = backgroundView
                cell.configCell(cast: cast[indexPath.row])
                return cell
            }
        }
        case reviewTableView: do {
            if let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell {
                let backgroundView = UIView()
                backgroundView.backgroundColor = .darkBlue
                cell.selectedBackgroundView = backgroundView
                
                
                
                cell.configure(with: reviews[indexPath.row])
                return cell
            }
        }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case castAndCrewTableView: do {
            return cast.count < 4 ? cast.count : 4
        }
        case reviewTableView: do {
            return reviews.count < 2 ? reviews.count : 2
        }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case castAndCrewTableView:
            100
        case reviewTableView:
            UITableView.automaticDimension
        default:
            100
        }
    }
}
