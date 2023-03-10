import UIKit

class ProfileViewController: UIViewController {
    private var avatarImage = UIImageView()
    private var nameLabel = UILabel()
    private var nickNameLabel = UILabel()
    private var messageLabel = UILabel()
    private var exitLabelButton = UIButton()
    
    private let profileService = ProfileService.shared
    private var token = OAuth2TokenStorage().token
        
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let token = token else { return }
        loadProfileData(token: token)
        print("Проверяю вывод текста в консоль")

        prepareView()
        addSubviews()
        addConstraints()
    }
    
    private func loadProfileData(token: String) {
        self.profileService.fetchProfile(token) { result in
            switch result {
            case .success(let profileResult):
                let profile = Profile(from: profileResult)
                self.messageLabel.text = profile.bio ?? ""
                self.nameLabel.text = profile.name
                self.nickNameLabel.text = profile.loginName
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    private func prepareView() {
        avatarImage.image = UIImage(named: "UserAvatar")
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 23, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nickNameLabel.text = "@ekaterina_nov"
        nickNameLabel.textColor = UIColor(named: "pGray")
        nickNameLabel.font = .systemFont(ofSize: 13)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.text = "Hello, world!"
        messageLabel.textColor = .white
        messageLabel.font = .systemFont(ofSize: 13)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        exitLabelButton = UIButton.systemButton(with: UIImage(named: "ExitImage")!,
                                                target: self,
                                                action: nil)
        exitLabelButton.tintColor = UIColor(named: "pRed")
        exitLabelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(nickNameLabel)
        view.addSubview(messageLabel)
        view.addSubview(exitLabelButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            
            nickNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nickNameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            
            exitLabelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            exitLabelButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -26)
        ])
    }
}
