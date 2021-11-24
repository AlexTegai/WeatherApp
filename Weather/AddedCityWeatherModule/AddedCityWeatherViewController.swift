//
//  AddedCityWeatherViewController.swift
//  Weather
//
//  Created by Alex Tegai on 26.10.2021.
//

import SnapKit

protocol AddedCityWeatherViewInputProtocol: AnyObject {
    func displayConditionColor(with condition: String)
    func displayCityName(with title: String)
    func displayImage(with imageData: Data)
    func displayCondition(with title: String)
    func displayTemperature(with value: String)
    func displayWindSpeed(with value: String)
    func displayHumidity(with value: String)
    func displayMinTemp(with value: String)
    func displayMaxTemp(with value: String)
    func displayFeelsLikeTemp(with value: String)
    func displayPressure(with value: String)
}

protocol AddedCityWeatherViewOutputProtocol: AnyObject {
    init(view: AddedCityWeatherViewInputProtocol)
    func showAddedCityWeather()
}

class AddedCityWeatherViewController: UIViewController {

    var presenter: AddedCityWeatherViewOutputProtocol!
        
    // MARK: - Private properties -
    
    private let headerStack = UIStackView()
    private let bodyStack = UIStackView()
    private let bodyFooterStack = UIStackView()
    private let footerStack = UIStackView()
    private let footerLeftStack = UIStackView()
    private let footerRightStack = UIStackView()
    private var averageTemperatureValueStack = UIStackView()
    private let feelsLikeValueStack = UIStackView()
    private let pressureValueStack = UIStackView()
    private let temperatureStack = UIStackView()
    
    // MARK: - UIViews -
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "San Francisco", font: .swiftBold, size: 32)
        return label
    }()
    
    private var conditionImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.fill")
        image.tintColor = .white
        return image
    }()
    
    private var conditionLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "Mostly Sunny", font: .swiftLight, size: 21)
        return label
    }()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "12", font: .swiftLight, size: 100)
        return label
    }()
    
    private var degreeLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "˚", font: .swiftLight, size: 100)
        return label
    }()
    
    private var windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")
        image.tintColor = .white
        return image
    }()
    
    private var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "8", font: .swiftLight, size: 17)
        return label
    }()
    
    private var windSpeedAttributeLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "M/Sec", font: .swiftLight, size: 17)
        return label
    }()
    
    private var dropImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "drop.fill")
        image.tintColor = .white
        return image
    }()
    
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "45", font: .swiftLight, size: 17)
        return label
    }()
    
    private var humidityAttributeLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "%", font: .swiftLight, size: 17)
        return label
    }()
    
    private var averageTemperatureLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "Average Temperature", font: .swiftLight, size: 17)
        return label
    }()
    
    
    private var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "Feels Like", font: .swiftLight, size: 17)
        return label
    }()
    
    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "Pressure", font: .swiftLight, size: 17)
        return label
    }()
    
    private var arrowDownImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.down")
        image.tintColor = .white
        return image
    }()
    
    private var minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "10", font: .swiftLight, size: 17)
        return label
    }()
    
    private var arrowUpImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.up")
        image.tintColor = .white
        return image
    }()

    private var maximumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "20", font: .swiftLight, size: 17)
        return label
    }()

    private var feelsLikeValueLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "14", font: .swiftLight, size: 17)
        return label
    }()

    private var pressureValueLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "900", font: .swiftLight, size: 17)
        return label
    }()

    private var pressureValueAttributeLabel: UILabel = {
        let label = UILabel()
        label.addSetupLabel(text: "hPa", font: .swiftLight, size: 17)
        return label
    }()
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        bodyStackViewConfigure()
        headerStackViewConfigure()
        footerStackViewConfigure()
        presenter.showAddedCityWeather()
    }
}

// MARK: - AddedCityWeatherViewInputProtocol -

extension AddedCityWeatherViewController: AddedCityWeatherViewInputProtocol {
    func displayConditionColor(with condition: String) {
        view.getConditionColor(with: condition)
    }
    
    func displayCityName(with title: String) {
        cityNameLabel.text = title
    }
    
    func displayImage(with imageData: Data) {
        conditionImage.image = UIImage(data: imageData)
    }
    
    func displayCondition(with title: String) {
        conditionLabel.text = title
    }
    
    func displayTemperature(with value: String) {
        tempLabel.text = value
    }
    
    func displayWindSpeed(with value: String) {
        windSpeedLabel.text = value
    }
    
    func displayHumidity(with value: String) {
        humidityLabel.text = value
    }
    
    func displayMinTemp(with value: String) {
        minimumTemperatureLabel.text = value
    }
    
    func displayMaxTemp(with value: String) {
        maximumTemperatureLabel.text = value
    }
    
    func displayFeelsLikeTemp(with value: String) {
        feelsLikeValueLabel.text = value
    }
    
    func displayPressure(with value: String) {
        pressureValueLabel.text = value
    }
}

// MARK: - UI -

extension AddedCityWeatherViewController {

    // MARK: - Header Stack -

    func headerStackViewConfigure() {
        view.addSubview(headerStack)
        headerStack.axis = .vertical
        headerStack.distribution = .fill
        headerStack.spacing = 5
        headerStack.alignment = .center
        
        headerStack.addArrangedSubview(cityNameLabel)
        headerStack.addArrangedSubview(conditionLabel)
        headerStack.addArrangedSubview(conditionImageConfigure())
        
        headerStack.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview().inset(40)
            make.bottom.greaterThanOrEqualTo(bodyStack).inset(170)
            make.centerX.equalToSuperview()
        }
    }

    func conditionImageConfigure() -> UIImageView {
        conditionImage.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(150)
            make.height.greaterThanOrEqualTo(150)
        }
        return conditionImage
    }
    
    // MARK: - Body Stack -
    
    func bodyStackViewConfigure() {
        bodyStack.axis = .vertical
        bodyStack.distribution = .fill
        bodyStack.spacing = 15
        bodyStack.alignment = .center
        
        bodyStack.addArrangedSubview(bodyTemperatureStackViewConfigure())
        bodyStack.addArrangedSubview(bodyFooterStackViewConfigure())
        
        view.addSubview(bodyStack)
        bodyStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Body Temp Stack -
    
    func bodyTemperatureStackViewConfigure() -> UIView {
        temperatureStack.axis = .horizontal
        temperatureStack.distribution = .fill
        temperatureStack.spacing = 2
        
        temperatureStack.addArrangedSubview(tempLabel)
        temperatureStack.addArrangedSubview(degreeLabel)
        
        return temperatureStack
    }
    
    // MARK: - Body Footer Stack -
    
    func bodyFooterStackViewConfigure() -> UIView {
        bodyFooterStack.axis = .horizontal
        bodyFooterStack.distribution = .fill
        bodyFooterStack.spacing = 10
        
        bodyFooterStack.addArrangedSubview(windImage)
        bodyFooterStack.addArrangedSubview(windSpeedLabel)
        bodyFooterStack.addArrangedSubview(windSpeedAttributeLabel)
        
        bodyFooterStack.addArrangedSubview(dropImage)
        bodyFooterStack.addArrangedSubview(humidityLabel)
        bodyFooterStack.addArrangedSubview(humidityAttributeLabel)
        
        return bodyFooterStack
    }
    
    // MARK: - Footer Main Stack -
    
    func footerStackViewConfigure() {
        footerStack.axis = .horizontal
        footerStack.distribution = .fill
        footerStack.spacing = 50
        
        footerStack.addArrangedSubview(footerLeftStackViewConfigure())
        footerStack.addArrangedSubview(footerRightStackConfigure())
        
        view.addSubview(footerStack)
        footerStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(25)
            make.top.greaterThanOrEqualTo(bodyStack).inset(280)
        }
    }

    // MARK: - Footer Left Stack -

    func footerLeftStackViewConfigure() -> UIView {
        footerLeftStack.axis = .vertical
        footerLeftStack.distribution = .fill
        footerLeftStack.spacing = 30
        
        footerLeftStack.addArrangedSubview(averageTemperatureLabel)
        footerLeftStack.addArrangedSubview(feelsLikeLabel)
        footerLeftStack.addArrangedSubview(pressureLabel)

        return footerLeftStack
    }
    
    // MARK: - Footer Right Stack -

    func footerRightStackConfigure() -> UIView {
        footerRightStack.axis = .vertical
        footerRightStack.distribution = .fill
        footerRightStack.alignment = .trailing
        footerRightStack.spacing = 30
        
        footerRightStack.addArrangedSubview(averageTempValueConfigure())
        footerRightStack.addArrangedSubview(feelsLikeValueConfigure())
        footerRightStack.addArrangedSubview(pressureValueConfigure())
        
        return footerRightStack
    }

    // MARK: - Footer Average Temp Value Stack -

    func averageTempValueConfigure() -> UIView {
        averageTemperatureValueStack.axis = .horizontal
        averageTemperatureValueStack.distribution = .fill
        averageTemperatureValueStack.spacing = 10
       
        averageTemperatureValueStack.addArrangedSubview(arrowDownImage)
        averageTemperatureValueStack.addArrangedSubview(minimumTemperatureLabel)
        averageTemperatureValueStack.addArrangedSubview(arrowUpImage)
        averageTemperatureValueStack.addArrangedSubview(maximumTemperatureLabel)
        
        return averageTemperatureValueStack
    }
    
    // MARK: - Footer Feels Like Value Stack -

    func feelsLikeValueConfigure() -> UIView {
        feelsLikeValueStack.axis = .horizontal
        feelsLikeValueStack.distribution = .fill
        feelsLikeValueStack.spacing = 10
        
        feelsLikeValueStack.addArrangedSubview(feelsLikeValueLabel)

        return feelsLikeValueStack
    }
    
    // MARK: - Footer Pressure Value Stack -
    
    func pressureValueConfigure() -> UIView {
        pressureValueStack.axis = .horizontal
        pressureValueStack.distribution = .fill
        pressureValueStack.spacing = 10
        
        pressureValueStack.addArrangedSubview(pressureValueLabel)
        pressureValueStack.addArrangedSubview(pressureValueAttributeLabel)
        
        return pressureValueStack
    }
}
