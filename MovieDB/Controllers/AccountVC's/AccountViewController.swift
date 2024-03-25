import UIKit

class AccountViewController: UIViewController {
    let adminButton = UIButton()
    let imageAdminButton = UIImageView()
    let profileLabel = UILabel()
    let avatarImage = UIImageView()
    let userNameLabel = UILabel()
    let lineOfView = UIView()
    let accountInformationButton = UIButton()
    let accountInformationImage = UIImageView()
    let privacyPolicyButton = UIButton()
    let privacyImage = UIImageView()
    let exitImage = UIImageView()
    let helpFaqImage = UIImageView()
    let helpFaqButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setConstraions()
        configExit()
        setConfigOfAccess()
        configAdminButton()
        configProfile()
        configProfileImage()
        configpPrivacyPolicyButton()
        configAccountInformation()
        configHelpButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConfigOfAccess()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
    }
    private func addSubViews() {
        [profileLabel,avatarImage,userNameLabel,lineOfView,accountInformationButton,accountInformationImage,privacyPolicyButton,privacyImage,adminButton,exitImage,imageAdminButton,helpFaqButton,helpFaqImage].forEach {
            self.view.addSubview($0)
        }
    }
    private func setConstraions(){
        [profileLabel,avatarImage,userNameLabel,lineOfView,accountInformationButton,accountInformationImage,privacyPolicyButton,privacyImage,adminButton,exitImage,imageAdminButton,helpFaqButton,helpFaqImage].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65),
            profileLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18)
        ])
        NSLayoutConstraint.activate([
            lineOfView.topAnchor.constraint(equalTo: self.profileLabel.bottomAnchor),
            lineOfView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            lineOfView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            lineOfView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: self.profileLabel.bottomAnchor, constant: 70),
            avatarImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            avatarImage.widthAnchor.constraint(equalToConstant: 90)
        ])
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 10),
            userNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            accountInformationButton.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 60),
            accountInformationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            accountInformationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            accountInformationButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            accountInformationImage.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 72),
            accountInformationImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            accountInformationImage.heightAnchor.constraint(equalToConstant: 20),
            accountInformationImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            privacyPolicyButton.topAnchor.constraint(equalTo: self.accountInformationButton.bottomAnchor, constant: 20),
            privacyPolicyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            privacyPolicyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            privacyPolicyButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            privacyImage.topAnchor.constraint(equalTo: self.accountInformationButton.bottomAnchor, constant: 32),
            privacyImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            privacyImage.heightAnchor.constraint(equalToConstant: 20),
            privacyImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            helpFaqButton.topAnchor.constraint(equalTo: self.privacyPolicyButton.bottomAnchor, constant: 20),
            helpFaqButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            helpFaqButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            helpFaqButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            helpFaqImage.topAnchor.constraint(equalTo: self.privacyPolicyButton.bottomAnchor, constant: 32),
            helpFaqImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            helpFaqImage.heightAnchor.constraint(equalToConstant: 20),
            helpFaqImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            adminButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -160),
            adminButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            adminButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            adminButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            imageAdminButton.centerYAnchor.constraint(equalTo: adminButton.centerYAnchor),
            imageAdminButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            imageAdminButton.heightAnchor.constraint(equalToConstant: 20),
            imageAdminButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            exitImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            exitImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            exitImage.widthAnchor.constraint(equalToConstant: 50),
            exitImage.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func configHelpButton() {
        helpFaqButton.setTitle(LoginUser.shared.user!.isAdmin ? "Chats" : "Help/FAQ", for: .normal)
        helpFaqButton.backgroundColor = .blueGray
        helpFaqButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        helpFaqButton.setTitleColor(.white, for: .normal)
        helpFaqButton.addTarget(self, action: #selector(HelpFAQTapped), for: .touchUpInside)
        helpFaqImage.image = UIImage(named: "ImageOfChats")
        
    }
    private func configExit(){
        if let image = UIImage(systemName: "figure.walk.departure") {
            exitImage.image = image.withRenderingMode(.alwaysTemplate)
            exitImage.tintColor = UIColor.white
        }
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(exitImageTapped))
        exitImage.isUserInteractionEnabled = true
        exitImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func exitImageTapped() {
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    @objc private func HelpFAQTapped() {
        if LoginUser.shared.user!.isAdmin {
            navigationController?.pushViewController(ChatsViewController(), animated: true)
        } else {
            navigationController?.pushViewController(HelpFAQViewController(userName: LoginUser.shared.user!.username, adminName: "Admin"), animated: true)
        }
    }
    private func configAccountInformation(){
        accountInformationButton.setTitle("Account Information", for: .normal)
        accountInformationButton.backgroundColor = .blueGray
        accountInformationButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        accountInformationImage.image = UIImage(named: "ImageThirdTabBar")
        accountInformationButton.addTarget(self, action: #selector(accountInformationButtonIsPressed), for: .touchUpInside)
    }
    private func configpPrivacyPolicyButton(){
        privacyPolicyButton.setTitle("Privacy policy", for: .normal)
        privacyImage.image = UIImage(named: "ImagePrivacy")
        privacyPolicyButton.backgroundColor = .blueGray
        privacyPolicyButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        privacyPolicyButton.setTitleColor(.white, for: .normal)
        privacyPolicyButton.addTarget(self, action: #selector(sharePolicy), for: .touchUpInside)
    }
    
    @objc public func sharePolicy() {
        if let url = URL(string: "https://www.themoviedb.org/dmca-policy") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    private func configAdminButton(){
        [adminButton,privacyPolicyButton,accountInformationButton].forEach{
            $0.layer.cornerRadius = 5
        }
        if LoginUser.shared.user?.isAdmin ?? false {
            adminButton.backgroundColor = .blueGray
            adminButton.setTitle("Administration", for: .normal)
            adminButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
            adminButton.setTitleColor(.white, for: .normal)
            imageAdminButton.image = UIImage(named: "ImageAdminButton")
        }
        adminButton.addTarget(self, action: #selector(adminButtonIsPressed), for: .touchUpInside)
    }
    private func configProfile(){
        [profileLabel,userNameLabel].forEach{
            $0.textColor = .white
            $0.font = UIFont(name: "Heebo-SemiBold", size: 24)
        }
        lineOfView.backgroundColor = .black
    }
    private func configProfileImage(){
        avatarImage.tintColor = .white
        avatarImage.layer.cornerRadius = 45
        avatarImage.backgroundColor = .black
        avatarImage.clipsToBounds = true
    }
    private func setConfigOfAccess(){
        if LoginUser.shared.user?.isAdmin ?? false {
            profileLabel.text = "Profile of Admin"
            userNameLabel.text = LoginUser.shared.user?.username
            avatarImage.image = UIImage(data: LoginUser.shared.user?.avatarImageData ?? Data()) ?? UIImage(systemName: "person.badge.key")
        }
        else {
            profileLabel.text = "Profile of User"
            avatarImage.image = UIImage(data: LoginUser.shared.user?.avatarImageData ?? Data()) ?? UIImage(systemName: "person.circle.fill")
            userNameLabel.text = LoginUser.shared.user?.username
        }
    }
    
    @objc private func handleSwipeBack(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc private func adminButtonIsPressed(_ gesture: UITapGestureRecognizer) {
        navigationController?.show(AdminVC(), sender: nil)
    }
    @objc private func accountInformationButtonIsPressed(_ gesture: UITapGestureRecognizer) {
        navigationController?.show(UpdateLoginViewController(), sender: nil)
    }
    
}
