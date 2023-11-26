import UIKit
import Alamofire
import YouTubeiOSPlayerHelper

class TrailersVC: UIViewController, TraillersVCProtocol {
    let tableView = UITableView()
    var trailers: [VideoResults] = []
    
    init(movieID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.fetchTrailers(movieID: movieID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchTrailers(movieID: Int) {
        let apiKey = "871ddc96a542d766d2b0fe03fc0ac3d1"
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)"
        AF.request(url).responseDecodable(of: Video.self) { response in
            switch response.result {
            case .success(let videoResponse):
                if let videos = videoResponse.results {
                        self.trailers = videos
                        self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkBlue
        self.setTitleNavBar(text: "Videos")
        
        setupElements()
    }
    
    internal func setupElements() {
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor.darkBlue
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TrailerCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func setupConstraints() {
        [tableView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - Extension
extension TrailersVC: UITableViewDelegate, UITableViewDataSource {
    /// Віставляє кількість блоків в таблиці ( TableView )
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    /// Повертає налаштований блок ( cell )
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TrailerCell {
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .darkBlue
            cell.selectedBackgroundView = backgroundView
            
            cell.configCell(result: trailers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    /// Задає висоту блоку ( cell )
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
  
}
