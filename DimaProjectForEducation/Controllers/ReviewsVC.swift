import UIKit
import Alamofire

class ReviewsVC: UIViewController, ReviewsVCProtocol {
    internal var reviews: [ReviewResult] = []
    var filmName: String = ""
    var reviewsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 10)
        label.textColor = .gray
        return label
    }()
    
    private var commentsTable: UITableView = {  // Коментарі до фільму
        let tableView = UITableView()
        tableView.backgroundColor = .darkBlue
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        tableView.register(NewReviewCell.self, forCellReuseIdentifier: "NewReviewCell")
        return tableView
    }()
    
    private var totalRating: UILabel = {  // Загальний рейтинг
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 38)
        label.textColor = .white
        return label
    }()
    
    
    private var totalRatingStars: UIStackView = {  // Загальний рейтинг в зірках
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private let totalRewiews: UILabel = {
        let label = UILabel()
        let textColor = UIColor(#colorLiteral(red: 0.5297212601, green: 0.5496682525, blue: 0.5879128575, alpha: 1))
        label.textColor = textColor
        label.font = UIFont(name: "Arial", size: 22)
        return label
    }()
    
    /// При ініціалізації передається id фільму для завантаження данних
    
    init(reviews: [ReviewResult], filmName: String) {
        super.init(nibName: nil, bundle: nil)
        self.reviews = reviews
        self.filmName = filmName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func fetchReviews(movieId: Int) {
        let apiKey = "871ddc96a542d766d2b0fe03fc0ac3d1"
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(apiKey)"
        
        AF.request(urlString).responseDecodable(of: Review.self) { response in
            switch response.result {
            case .success(let review):
                if let results = review.results {
                    self.reviews = results
                    self.calculateAverageRating()
                    self.totalRewiews.text = "\(self.reviews.count) Rewiews"
                    self.commentsTable.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    internal func calculateAverageRating() {
        var totalAverage = 0
        
        if !reviews.isEmpty {
            let sum = reviews.reduce(0.0) { $0 + ($1.author_details?.rating ?? 0.0) }
            totalAverage = Int((sum / Double(reviews.count)) / 2)
        }
        
        setupStarsStackView(rating: totalAverage)
    }
    
    internal func setupStarsStackView(rating: Int) {
        totalRating.text = "\(rating)/5"
        if rating >= 0 && rating <= 5 {
            totalRatingStars.distribution = .equalSpacing
            
            let filllStarImage = UIImage(systemName: "star.fill")
            let starImage = UIImage(systemName: "star")
            let starTintColor = UIColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
            
            for count in 1...5 {
                let starView = UIImageView(image: count <= rating ? filllStarImage : starImage)
                starView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                starView.tintColor = starTintColor

                if totalRatingStars.arrangedSubviews.count < 5 {
                    totalRatingStars.addArrangedSubview(starView)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue
        self.setTitleNavBar(text: "Reviews")
        
        setupElements()
        setupConstraints()
        calculateAverageRating()
     }
    
    internal func setupElements() {
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.separatorStyle = .none
        
        totalRewiews.text = "\(reviews.count) comment" + (reviews.count == 1 ? "" : "s")
        [commentsTable, totalRating, totalRatingStars, totalRewiews].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    internal func setupConstraints() {
        NSLayoutConstraint.activate([
            commentsTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            commentsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            commentsTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentsTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totalRating.bottomAnchor.constraint(equalTo: self.commentsTable.topAnchor, constant: -60),
            totalRating.leadingAnchor.constraint(equalTo: self.commentsTable.leadingAnchor, constant: 80)
        ])
        
        NSLayoutConstraint.activate([
            totalRatingStars.leadingAnchor.constraint(equalTo: totalRating.trailingAnchor, constant: 10),
            totalRatingStars.centerYAnchor.constraint(equalTo: totalRating.centerYAnchor),
            totalRatingStars.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            totalRewiews.topAnchor.constraint(equalTo: totalRatingStars.bottomAnchor),
            totalRewiews.leadingAnchor.constraint(equalTo: totalRatingStars.leadingAnchor, constant: -10),
            totalRewiews.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    /// Виставляє кількість блоків в таблиці ( TableView )
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    /// Повертає налаштований блок ( cell )
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < reviews.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            let backgroundView = UIView()
            backgroundView.backgroundColor = .darkBlue
            cell.selectedBackgroundView = backgroundView
            let review = reviews[indexPath.row]
            cell.configure(with: review)
            
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewReviewCell", for: indexPath) as? NewReviewCell {
                cell.configCell(filmName: filmName)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    /// Задає висоту cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < reviews.count {
            return UITableView.automaticDimension
        } else {
            return 170
        }
    }
}

