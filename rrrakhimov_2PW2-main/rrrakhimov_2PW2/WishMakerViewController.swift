//
//  WishMakerViewController.swift
//  rrrakhimov_2PW2
//
//  Created by Рамазан Рахимов on 10/4/23.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    private enum Constants {
        static let sliderMinValue: Double = 0
        static let sliderMaxValue: Double = 255
        static let sliderRedMaxValue: Double = 1
        static let stackCornerRadius: CGFloat = 20
        static let leadingAndTrailingPadding: CGFloat = 20
        static let stackBottomPadding: CGFloat = -95
        
        // AddWishButton Constants
        static let buttonHeight: CGFloat = 50 // Example value, adjust as needed
        static let buttonBottom: CGFloat = 20 // Distance from the bottom of the view
        static let buttonSide: CGFloat = 20 // Horizontal padding from the side of the view
        static let buttonText: String = "Add Wish" // Button title
        static let buttonRadius: CGFloat = 10 // Corner radius for the button
    }
    
    private let toggleSlidersButton = UIButton()
    private let hexTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter HEX (e.g., #FF5733)"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let addWishButton: UIButton = UIButton(type: .system)
    private func configureAddWishButton() {
        view.addSubview(addWishButton)

        addWishButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addWishButton.topAnchor.constraint(equalTo: slidersStackView.bottomAnchor, constant: 20), // Расстояние между слайдерами и кнопкой
            addWishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonSide),
            addWishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonSide),
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])

        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonRadius

        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }

    private let slidersStackView = UIStackView()
    
    @objc private func addWishButtonPressed() {
            let wishStoringVC = WishStoringViewController()
            present(wishStoringVC, animated: true)
        }
    
    private let randomColorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Random Color", for: .normal)
        button.backgroundColor = .systemGray2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let sliderRed = CustomSlider(title: "Red", min: Constants.sliderMinValue, max: Constants.sliderMaxValue)
    private let sliderBlue = CustomSlider(title: "Blue", min: Constants.sliderMinValue, max: Constants.sliderMaxValue)
    private let sliderGreen = CustomSlider(title: "Green", min: Constants.sliderMinValue, max: Constants.sliderMaxValue)
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToggleSlidersButton()
        configureUI()
        configureRandomColorButton()
        configureHexTextField()
        configureConstraints()
        configureAddWishButton()
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            randomColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomColorButton.bottomAnchor.constraint(equalTo: toggleSlidersButton.topAnchor, constant: -80), // Выберите правильное значение константы
            randomColorButton.widthAnchor.constraint(equalToConstant: 200),
            randomColorButton.heightAnchor.constraint(equalToConstant: 50),
            
            hexTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexTextField.topAnchor.constraint(equalTo: randomColorButton.bottomAnchor, constant: 20),
            hexTextField.widthAnchor.constraint(equalToConstant: 200),
            hexTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureToggleSlidersButton() {
        toggleSlidersButton.translatesAutoresizingMaskIntoConstraints = false
        toggleSlidersButton.setTitle("Toggle Sliders", for: .normal)
        toggleSlidersButton.backgroundColor = .systemGray2
        toggleSlidersButton.setTitleColor(.white, for: .normal)
        toggleSlidersButton.layer.cornerRadius = 10
        toggleSlidersButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        view.addSubview(toggleSlidersButton)
        
        NSLayoutConstraint.activate([
            toggleSlidersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleSlidersButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleSlidersButton.widthAnchor.constraint(equalToConstant: 200),
            toggleSlidersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        toggleSlidersButton.addTarget(self, action: #selector(toggleSliders), for: .touchUpInside)
    }
    
    
    @objc private func hexChanged() {
        guard let hexString = hexTextField.text, hexString.count == 7 else { return }
        view.backgroundColor = UIColor(hexString: hexString)
    }
    
    private func configureRandomColorButton() {
        view.addSubview(randomColorButton)
        
        randomColorButton.addTarget(self, action: #selector(randomColor), for: .touchUpInside)
    }
    
    private func configureHexTextField() {
        view.addSubview(hexTextField)
        NSLayoutConstraint.activate([
            hexTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexTextField.topAnchor.constraint(equalTo: randomColorButton.bottomAnchor, constant: 20),
            hexTextField.widthAnchor.constraint(equalToConstant: 200),
            hexTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        hexTextField.addTarget(self, action: #selector(hexChanged), for: .editingChanged)
    }
    
    @objc private func randomColor() {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    @objc private func toggleSliders() {
        let isHidden = sliderRed.isHidden
        sliderRed.isHidden = !isHidden
        sliderBlue.isHidden = !isHidden
        sliderGreen.isHidden = !isHidden
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureTitle()
        configureDescriptionLabel()
        configureSliders()
    }
    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "WishMaker"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Adjust the sliders to change the background color."
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureSliders() {
        slidersStackView.translatesAutoresizingMaskIntoConstraints = false
            slidersStackView.axis = .vertical
            slidersStackView.layer.cornerRadius = Constants.stackCornerRadius
            slidersStackView.clipsToBounds = true

            view.addSubview(slidersStackView)

            [sliderRed, sliderBlue, sliderGreen].forEach {
                slidersStackView.addArrangedSubview($0)
            }

            NSLayoutConstraint.activate([
                slidersStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                slidersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAndTrailingPadding),
                slidersStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottomPadding)
            ])
        sliderRed.valueChanged = { [weak self] _ in
            self?.updateBackgroundColor()
        }
        sliderBlue.valueChanged = { [weak self] _ in
            self?.updateBackgroundColor()
        }
        sliderGreen.valueChanged = { [weak self] _ in
            self?.updateBackgroundColor()
        }
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = UIColor(
            red: CGFloat(sliderRed.slider.value / 255),
            green: CGFloat(sliderGreen.slider.value / 255),
            blue: CGFloat(sliderBlue.slider.value / 255),
            alpha: 1.0
        )
    }
    
}

final class CustomSlider: UIView {
    
    var valueChanged: ((Double) -> Void)?
    
    private(set) var slider = UISlider()
    private var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        [slider, titleView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    @objc private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner            = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Int(color >> 16) & mask) / 255.0
        let g = CGFloat(Int(color >> 8) & mask) / 255.0
        let b = CGFloat(Int(color) & mask) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}






