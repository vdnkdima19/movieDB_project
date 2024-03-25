import UIKit

class GenreVC: UIViewController{
    var genresLabel = UILabel()
    var actionButton = UIButton()
    var adventureButton = UIButton()
    var animationButton = UIButton()
    var comedyButton = UIButton()
    var crimeButton = UIButton()
    var documentaryButton = UIButton()
    var dramaButton = UIButton()
    var familyButton = UIButton()
    var fantasyButton = UIButton()
    var historyButton = UIButton()
    var horrorButton = UIButton()
    var musicButton = UIButton()
    var mysteryButton = UIButton()
    var romanceButton = UIButton()
    var scienceFictionButton = UIButton()
    var tvMovieButton = UIButton()
    var thrillerButton = UIButton()
    var warButton = UIButton()
    var westernButton = UIButton()
    
    var isGenreSelected = false
    
    var genres: [Int] = []
    var searchButton = UIButton()
    var movievc: MovieVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        addSubviews()
        setConstraints()
        configLabel()
        configGenresButtons()
        configSearchButton()
        addTargetForChildElements()
        
    }
    private func defaultConfigButtons(){
        for genreButton in [
            actionButton, adventureButton, animationButton, comedyButton, crimeButton,
            documentaryButton, dramaButton, familyButton, fantasyButton, historyButton,
            horrorButton, musicButton, mysteryButton, romanceButton, scienceFictionButton,
            tvMovieButton, thrillerButton, warButton, westernButton
        ] {
            buttonIsUnselected(genreButton)
        }
        if genres.contains(where: {$0 == 28}){
            buttonIsSelected(actionButton)
        }
        if genres.contains(where: {$0 == 12}){
            buttonIsSelected(adventureButton)
        }
        if genres.contains(where: {$0 == 16}){
            buttonIsSelected(animationButton)
        }
        if genres.contains(where: {$0 == 35}){
            buttonIsSelected(comedyButton)
        }
        if genres.contains(where: {$0 == 80}){
            buttonIsSelected(crimeButton)
        }
        if genres.contains(where: {$0 == 99}){
            buttonIsSelected(documentaryButton)
        }
        if genres.contains(where: {$0 == 18}){
            buttonIsSelected(dramaButton)
        }
        if genres.contains(where: {$0 == 10751}){
            buttonIsSelected(familyButton)
        }
        if genres.contains(where: {$0 == 14}){
            buttonIsSelected(fantasyButton)
        }
        if genres.contains(where: {$0 == 36}){
            buttonIsSelected(historyButton)
        }
        if genres.contains(where: {$0 == 27}){
            buttonIsSelected(horrorButton)
        }
        if genres.contains(where: {$0 == 10402}){
            buttonIsSelected(musicButton)
        }
        if genres.contains(where: {$0 == 9648}){
            buttonIsSelected(mysteryButton)
        }
        if genres.contains(where: {$0 == 10749}){
            buttonIsSelected(romanceButton)
        }
        if genres.contains(where: {$0 == 878}){
            buttonIsSelected(scienceFictionButton)
        }
        if genres.contains(where: {$0 == 10770}){
            buttonIsSelected(tvMovieButton)
        }
        if genres.contains(where: {$0 == 53}){
            buttonIsSelected(thrillerButton)
        }
        if genres.contains(where: {$0 == 10752}){
            buttonIsSelected(warButton)
        }
        if genres.contains(where: {$0 == 37}){
            buttonIsSelected(westernButton)
        }
    }
    private func buttonIsUnselected(_ sender: UIButton){
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    private func buttonIsSelected(_ sender: UIButton){
        sender.backgroundColor = .backgroundColorLaunchScreen
        sender.setTitleColor(.white, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        defaultConfigButtons()
    }
    public func addSubviews() {
        [genresLabel,actionButton,adventureButton,animationButton,comedyButton,crimeButton,documentaryButton,dramaButton,familyButton,fantasyButton,historyButton,horrorButton,musicButton,mysteryButton,romanceButton,scienceFictionButton,tvMovieButton,thrillerButton,warButton,westernButton,searchButton].forEach {
            view.addSubview($0)
        }
    }
    public func setConstraints() {
        [genresLabel,actionButton,adventureButton,animationButton,comedyButton,crimeButton,documentaryButton,dramaButton,familyButton,fantasyButton,historyButton,horrorButton,musicButton,mysteryButton,romanceButton,scienceFictionButton,tvMovieButton,thrillerButton,warButton,westernButton,searchButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: self.view.topAnchor,constant: -30),
            genresLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            genresLabel.heightAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: self.genresLabel.bottomAnchor,constant: -50),
            actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            adventureButton.topAnchor.constraint(equalTo: self.genresLabel.bottomAnchor,constant: -50),
            adventureButton.leadingAnchor.constraint(equalTo:self.actionButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            animationButton.topAnchor.constraint(equalTo: self.actionButton.bottomAnchor,constant: 20),
            animationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            comedyButton.topAnchor.constraint(equalTo: self.adventureButton.bottomAnchor,constant: 20),
            comedyButton.leadingAnchor.constraint(equalTo: self.animationButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            crimeButton.topAnchor.constraint(equalTo: self.animationButton.bottomAnchor,constant: 20),
            crimeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            documentaryButton.topAnchor.constraint(equalTo: self.comedyButton.bottomAnchor,constant: 20),
            documentaryButton.leadingAnchor.constraint(equalTo: self.crimeButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            dramaButton.topAnchor.constraint(equalTo: self.crimeButton.bottomAnchor,constant: 20),
            dramaButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            familyButton.topAnchor.constraint(equalTo: self.documentaryButton.bottomAnchor,constant: 20),
            familyButton.leadingAnchor.constraint(equalTo: self.dramaButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            fantasyButton.topAnchor.constraint(equalTo: self.dramaButton.bottomAnchor,constant: 20),
            fantasyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: self.familyButton.bottomAnchor,constant: 20),
            historyButton.leadingAnchor.constraint(equalTo: self.fantasyButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            horrorButton.topAnchor.constraint(equalTo: self.fantasyButton.bottomAnchor,constant: 20),
            horrorButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            musicButton.topAnchor.constraint(equalTo: self.fantasyButton.bottomAnchor,constant: 20),
            musicButton.leadingAnchor.constraint(equalTo: self.horrorButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            mysteryButton.topAnchor.constraint(equalTo: self.fantasyButton.bottomAnchor,constant: 20),
            mysteryButton.leadingAnchor.constraint(equalTo: self.musicButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            romanceButton.topAnchor.constraint(equalTo: self.horrorButton.bottomAnchor,constant: 20),
            romanceButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            scienceFictionButton.topAnchor.constraint(equalTo: self.horrorButton.bottomAnchor,constant: 20),
            scienceFictionButton.leadingAnchor.constraint(equalTo: self.romanceButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            tvMovieButton.topAnchor.constraint(equalTo: self.romanceButton.bottomAnchor,constant: 20),
            tvMovieButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            thrillerButton.topAnchor.constraint(equalTo: self.romanceButton.bottomAnchor,constant: 20),
            thrillerButton.leadingAnchor.constraint(equalTo: self.tvMovieButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            warButton.topAnchor.constraint(equalTo: self.romanceButton.bottomAnchor,constant: 20),
            warButton.leadingAnchor.constraint(equalTo: self.thrillerButton.trailingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            westernButton.topAnchor.constraint(equalTo: self.tvMovieButton.bottomAnchor,constant: 20),
            westernButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20)
        ])
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -90),
            searchButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20)
        ])
    }
    private func configLabel() {
        genresLabel.text = "Genres"
        genresLabel.font = UIFont(name: "Montserrat-Medium", size: 36)
        genresLabel.textColor = .white
    }
    private func configGenresButtons() {
        [actionButton,adventureButton,animationButton,comedyButton,crimeButton,documentaryButton,dramaButton,familyButton,fantasyButton,historyButton,horrorButton,musicButton,mysteryButton,romanceButton,scienceFictionButton,tvMovieButton,thrillerButton,warButton,westernButton].forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = true
            $0.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
            $0.setTitleColor(.black, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        actionButton.setTitle("Action", for: .normal)
        adventureButton.setTitle("Adventure", for: .normal)
        animationButton.setTitle("Animation", for: .normal)
        comedyButton.setTitle("Comedy", for: .normal)
        crimeButton.setTitle("Crime", for: .normal)
        documentaryButton.setTitle("Documentary", for: .normal)
        dramaButton.setTitle("Drama", for: .normal)
        familyButton.setTitle("Family", for: .normal)
        fantasyButton.setTitle("Fantasy", for: .normal)
        historyButton.setTitle("History", for: .normal)
        horrorButton.setTitle("Horror", for: .normal)
        musicButton.setTitle("Music", for: .normal)
        mysteryButton.setTitle("Mystery", for: .normal)
        romanceButton.setTitle("Romance", for: .normal)
        scienceFictionButton.setTitle("Science Fiction", for: .normal)
        tvMovieButton.setTitle("TV Movie", for: .normal)
        thrillerButton.setTitle("Thriller", for: .normal)
        warButton.setTitle("War", for: .normal)
        westernButton.setTitle("Western", for: .normal)
    }
    private func configSearchButton() {
        searchButton.backgroundColor = .systemGray6
        searchButton.layer.cornerRadius = 25
        searchButton.layer.masksToBounds = true
        searchButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 25)
        searchButton.setTitleColor(.darkGray, for: .normal)
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        searchButton.setTitle("Search", for: .normal)
    }
    private func addTargetForChildElements(){
        for genreButton in [
            actionButton, adventureButton, animationButton, comedyButton, crimeButton,
            documentaryButton, dramaButton, familyButton, fantasyButton, historyButton,
            horrorButton, musicButton, mysteryButton, romanceButton, scienceFictionButton,
            tvMovieButton, thrillerButton, warButton, westernButton,searchButton
        ] {
            genreButton.addTarget(self, action: #selector(buttonIsPresed), for: .touchUpInside)
        }
    }
    @objc private func buttonIsPresed(_ sender: UIButton) {
        switch sender {
        case actionButton: do {
            if !genres.contains(where: {$0 == 28}){
                genres.append(28)
            }
            else {
                genres.removeAll(where: {$0 == 28})
            }
        }
        case adventureButton: do {
            if !genres.contains(where: {$0 == 12}){
                genres.append(12)
            }
            else {
                genres.removeAll(where: {$0 == 12})
            }
        }
        case animationButton: do {
            if !genres.contains(where: {$0 == 16}){
                genres.append(16)
            }
            else {
                genres.removeAll(where: {$0 == 16})
            }
        }
        case comedyButton: do {
            if !genres.contains(where: {$0 == 35}){
                genres.append(35)
            }
            else {
                genres.removeAll(where: {$0 == 35})
            }
        }
        case crimeButton: do {
            if !genres.contains(where: {$0 == 80}){
                genres.append(80)
            }
            else {
                genres.removeAll(where: {$0 == 80})
            }
        }
        case documentaryButton: do {
            if !genres.contains(where: {$0 == 99}){
                genres.append(99)
            }
            else {
                genres.removeAll(where: {$0 == 99})
            }
        }
        case dramaButton: do {
            if !genres.contains(where: {$0 == 18}){
                genres.append(18)
            }
            else {
                genres.removeAll(where: {$0 == 18})
            }
        }
        case familyButton: do {
            if !genres.contains(where: {$0 == 10751}){
                genres.append(10751)
            }
            else {
                genres.removeAll(where: {$0 == 10751})
            }
        }
        case fantasyButton: do {
            if !genres.contains(where: {$0 == 14}){
                genres.append(14)
            }
            else {
                genres.removeAll(where: {$0 == 14})
            }
        }
        case historyButton: do {
            if !genres.contains(where: {$0 == 36}){
                genres.append(36)
            }
            else {
                genres.removeAll(where: {$0 == 36})
            }
        }
        case horrorButton: do {
            if !genres.contains(where: {$0 == 27}){
                genres.append(27)
            }
            else {
                genres.removeAll(where: {$0 == 27})
            }
        }
        case musicButton: do {
            if !genres.contains(where: {$0 == 10402}){
                genres.append(10402)
            }
            else {
                genres.removeAll(where: {$0 == 10402})
            }
        }
        case mysteryButton: do {
            if !genres.contains(where: {$0 == 9648}){
                genres.append(9648)
            }
            else {
                genres.removeAll(where: {$0 == 9648})
            }
        }
        case romanceButton: do {
            if !genres.contains(where: {$0 == 10749}){
                genres.append(10749)
            }
            else {
                genres.removeAll(where: {$0 == 10749})
            }
        }
        case scienceFictionButton: do {
            if !genres.contains(where: {$0 == 878}){
                genres.append(878)
            }
            else {
                genres.removeAll(where: {$0 == 878})
            }
        }
        case tvMovieButton: do {
            if !genres.contains(where: {$0 == 10770}){
                genres.append(10770)
            }
            else {
                genres.removeAll(where: {$0 == 10770})
            }
        }
        case thrillerButton: do {
            if !genres.contains(where: {$0 == 53}){
                genres.append(53)
            }
            else {
                genres.removeAll(where: {$0 == 53})
            }
        }
        case warButton: do {
            if !genres.contains(where: {$0 == 10752}){
                genres.append(10752)
            }
            else {
                genres.removeAll(where: {$0 == 10752})
            }
        }
        case westernButton: do {
            if !genres.contains(where: {$0 == 37}){
                genres.append(37)
            }
            else {
                genres.removeAll(where: {$0 == 37})
            }
        }
        case searchButton: do {
            movievc?.genre_ids = genres
            movievc?.fetchMoviesInfoWithGenres(genre_id: movievc?.genre_ids ?? [],onClearArray: true,numOfPage: 1, isComingSoon: false)
            movievc?.movieCollectionView.reloadData()
            navigationController?.popViewController(animated: true)
        }
        default:
            break
        }
        
    }
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.titleColor(for: .normal) == .black {
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = .backgroundColorLaunchScreen
        } else {
            sender.setTitleColor(.black, for: .normal)
            sender.backgroundColor = .white
        }
                if isAnyGenreButtonSelected() {
                    searchButton.backgroundColor = .backgroundColorLaunchScreen
                    searchButton.setTitleColor(.white, for: .normal)
                } else {
                    searchButton.backgroundColor = .backgroundColorLaunchScreen
                    searchButton.setTitleColor(.white, for: .normal)
                }
    }
    private func isAnyGenreButtonSelected() -> Bool {
           for genreButton in [
               actionButton, adventureButton, animationButton, comedyButton, crimeButton,
               documentaryButton, dramaButton, familyButton, fantasyButton, historyButton,
               horrorButton, musicButton, mysteryButton, romanceButton, scienceFictionButton,
               tvMovieButton, thrillerButton, warButton, westernButton
           ] {
               if genreButton.titleColor(for: .normal) == .white {
                   return true
               }
           }
           return false
       }
}
