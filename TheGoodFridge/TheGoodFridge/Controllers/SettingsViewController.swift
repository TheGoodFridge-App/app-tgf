//
//  SettingsViewController.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SettingsViewController: UIViewController {
    
    let settingsSymbol: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let downButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "SettingsDownImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Amiko-Regular", size: 24)
        return label
    } ()
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("SIGN OUT", for: .normal)
        button.setTitleColor(UIColor(red: 0.424, green: 0.683, blue: 0.305, alpha: 1), for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Amiko-Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signOutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1)
        return view
    }()
    
    //profile picture
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DefaultProfilePicture")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let editProfileIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "EditProfileIcon")
        icon.isUserInteractionEnabled = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .darkGray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let settingsPage = SettingsView()
    let tableView = UITableView()
    
    let settingsSections = [
        "APP SUPPORT"
    ]
    
    let settingsEntries = [
        ["FAQ", "PRIVACY POLICY"]
    ]
    
    let entryHeight: CGFloat = 55
    let profileSize: CGFloat = 100
    let spacing: CGFloat = 12
    var profileDelegate: ProfileDelegate?
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pre-condition check
        if settingsSections.count != settingsEntries.count {
            debugPrint("Number of sections and entries per section do not match in settings")
            return
        }
        
        // Tap gesture for edit photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedEditPhoto))
        editProfileIcon.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .white
        
        // Nav bar setup
        navigationItem.titleView = settingsLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsSymbol)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: downButton)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        	
        // Table view setup
        tableView.register(SettingsItemCell.self, forCellReuseIdentifier: K.settingsCellID)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        // Button setup
        downButton.addTarget(self, action: #selector(tappedDownButton), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(tappedSignOutButton), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(profilePicture)
        view.addSubview(editProfileIcon)
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        signOutView.addSubview(signOutButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let iconSize: CGFloat = 20
        let editIconMargin: CGFloat = 12
        
        let constraints = [
            profilePicture.widthAnchor.constraint(equalToConstant: profileSize),
            profilePicture.heightAnchor.constraint(equalToConstant: profileSize),
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing),
            
            editProfileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editProfileIcon.widthAnchor.constraint(equalToConstant: iconSize),
            editProfileIcon.heightAnchor.constraint(equalToConstant: iconSize),
            editProfileIcon.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: editIconMargin),
            
            tableView.topAnchor.constraint(equalTo: editProfileIcon.bottomAnchor, constant: spacing),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            signOutButton.widthAnchor.constraint(equalTo: signOutView.widthAnchor, multiplier: 1/3),
            signOutButton.centerXAnchor.constraint(equalTo: signOutView.centerXAnchor),
            signOutButton.topAnchor.constraint(equalTo: signOutView.topAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: signOutView.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                             constant: -(navigationController?.navigationBar.frame.size.height ?? 0)),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Profile Image Selection", message: "From where do you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func tappedEditPhoto() {
        showAlert()
    }
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    @objc func tappedDownButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedSignOutButton() {
        GIDSignIn.sharedInstance()?.signOut()  //Auth.auth().signOut()
        UserDefaults.standard.set(false, forKey: "loggedIn")
        
        // Setting root view controller of scene delegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                fatalError("Could not get scene delegate")
        }
        // Setting up transition
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .moveIn
        transition.subtype = .fromTop
        transition.timingFunction = CAMediaTimingFunction(name: .default)
        
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.spinner.stopAnimating()
            sceneDelegate.window?.layer.add(transition, forKey: kCATransition)
            sceneDelegate.window?.rootViewController = WelcomeViewController()
            sceneDelegate.window?.isHidden = false
        }
    }
    
    private func tappedAccountDetailsButton() {
        let accountVC = AccountDetailsViewController()
        self.navigationController?.pushViewController(accountVC, animated: true)
    }
    
    private func tappedPrivacyPageButton() {
        let privacyVC = PrivacyPolicyViewController()
        self.navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    private func tappedFAQButton() {
        let faqVC = FAQViewController()
        self.navigationController?.pushViewController(faqVC, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height / 2
    }

}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsEntries[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return entryHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return section == settingsSections.count - 1 ? signOutView : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == settingsSections.count - 1 ? entryHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let settingsTitleView = SettingsSectionTitleView()
        if section == 0 {
            settingsTitleView.hideSeparatorView()
        }
        settingsTitleView.setText(to: settingsSections[section])
        return settingsTitleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return entryHeight * 1.15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch settingsEntries[indexPath.section][indexPath.row] {
        case "ACCOUNT DETAILS":
            tappedAccountDetailsButton()
        case "FAQ":
            tappedFAQButton()
        case "PRIVACY POLICY":
            tappedPrivacyPageButton()
        default:
            break
        }
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.settingsCellID) as! SettingsItemCell
        let text = settingsEntries[indexPath.section][indexPath.row]
        cell.setText(to: text)
        cell.selectedBackgroundView = UIView()
        return cell
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = sourceType
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
            self.profilePicture.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = originalImage
            self.profilePicture.image = originalImage
        }
        
        if let image = selectedImage {
            user.setImage(to: image)
            profileDelegate?.didGetProfilePicture(image: image)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
