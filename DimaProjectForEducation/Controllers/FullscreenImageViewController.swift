import UIKit

class FullscreenImageViewController: UIViewController {
    private let imageView: UIImageView
    
    init(image: UIImage?) {
        self.imageView = UIImageView(image: image)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleNavBar(text: "Poster")
        view.backgroundColor = .darkBlue
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -80),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
