//
//  SettingViewController.swift
//  Table View app
//
//  Created by Adlet Zhantassov on 27.03.2023.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    var newPlace: Place?
    var dataClosure: ((Place) -> Void)?
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default")
        return imageView
    }()
    
    lazy var name: UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var location: UILabel = {
       let label = UILabel()
        label.text = "Location"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var type: UILabel = {
       let label = UILabel()
        label.text = "Type"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Place name"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray5
        let leftView = UIView()
        let rightView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        rightView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        tf.leftView = leftView
        tf.delegate = self
        tf.returnKeyType = .done
        tf.leftViewMode = .always
        tf.rightView = rightView
        tf.rightViewMode = .always
        tf.addTarget(self, action: #selector(nameTFChanged), for: .editingChanged)
        return tf
    }()
    
    lazy var locationTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Place location"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray5
        let leftView = UIView()
        let rightView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        rightView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        tf.leftView = leftView
        tf.delegate = self
        tf.returnKeyType = .done
        tf.leftViewMode = .always
        tf.rightView = rightView
        tf.rightViewMode = .always
        return tf
    }()
    
    lazy var typeTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Place type"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray5
        let leftView = UIView()
        let rightView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        rightView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        tf.leftView = leftView
        tf.delegate = self
        tf.returnKeyType = .done
        tf.leftViewMode = .always
        tf.rightView = rightView
        tf.rightViewMode = .always
        return tf
    }()
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        item.isEnabled = false
        return item
    }()
    
    private lazy var imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(imageButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "New Place"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = saveBarButtonItem
        setupViews()
        setupConstraints()
    }
    
    @objc private func cancelButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonPressed() {
        newPlace = Place(name: nameTF.text!, location: locationTF.text, type: typeTF.text, image: nil, placeImage: foodImageView.image)
        if let newPlace = newPlace {
            dataClosure?(newPlace)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func imageButtonPressed() {
        
        let cameraIcon = UIImage(systemName: "camera")
        let photoIcon = UIImage(systemName: "photo")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(photoIcon, forKeyPath: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(foodImageView)
        view.addSubview(name)
        view.addSubview(location)
        view.addSubview(type)
        view.addSubview(nameTF)
        view.addSubview(locationTF)
        view.addSubview(typeTF)
        view.addSubview(imageButton)
    }
    
    private func setupConstraints() {
        
        imageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(view.snp.leading).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
            make.height.equalTo(foodImageView.snp.height)
        }
        
        foodImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(view.snp.leading).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
            make.height.equalTo(view.frame.size.height/3.7)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
        }
        
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
        }
        
        location.snp.makeConstraints { make in
            make.top.equalTo(nameTF.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
        }
        
        locationTF.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
        }
        
        type.snp.makeConstraints { make in
            make.top.equalTo(locationTF.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
        }
        
        typeTF.snp.makeConstraints { make in
            make.top.equalTo(type.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
        }
    }
}

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func nameTFChanged() {
        if nameTF.text?.isEmpty == false {
            saveBarButtonItem.isEnabled = true
        } else {
            saveBarButtonItem.isEnabled = false
        }
    }
}

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        foodImageView.image = info[.editedImage] as? UIImage
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        dismiss(animated: true)
    }
}
