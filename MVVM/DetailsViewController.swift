//
//  DetailsViewController.swift
//  MVVM
//
//  Created by Nikita Beglov on 26.06.2024.
//

import UIKit
import SnapKit

final class DetailsViewController: UIViewController {

    private var viewModel: DetailsViewModelProtocol
    private let activityIndicator = UIActivityIndicatorView()

    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            strFirstRatingLabel,
            intFirstRatingLabel,
            strSecondRatingLabel,
            intSecondRatingLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()

    private lazy var strFirstRatingLabel = UILabel()
    private lazy var intFirstRatingLabel = UILabel()
    private lazy var strSecondRatingLabel = UILabel()
    private lazy var intSecondRatingLabel = UILabel()
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 200))
        return imageView
    }()

// MARK: - Description Views

    private lazy var nameRuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private lazy var nameOriginalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()

    private lazy var strYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var intYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private lazy var strTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var intTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViews()
        setupConstraints()
    }

    private func bindView() {
        viewModel.onDataLoaded = { [weak self] in
            guard let self = self else { return }
            self.configure()
        }
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func configure() {
        guard let model = viewModel.filmDescription else { return }
        strFirstRatingLabel.text = "Kinopoisk"
        strSecondRatingLabel.text = "IMBD"
        strYearLabel.text = "Year"
        strTimeLabel.text = "Продолжительность"
        intFirstRatingLabel.text = "\(model.ratingKinopoisk ?? 0)"
        intSecondRatingLabel.text = "\(model.ratingImdb ?? 0)"
        nameRuLabel.text = model.nameRu
        nameOriginalLabel.text = model.nameOriginal
        descriptionLabel.text = model.description
        intYearLabel.text = "\(model.year ?? 2000)"
        intTimeLabel.text = "\(model.filmLength ?? 0)"
        posterImage.load(url: model.posterUrl!)
    }
}

// MARK: ConfigureUI

private extension DetailsViewController {
    private func setupViews() {
        view.addSubview(ratingStackView)
        view.addSubview(posterImage)
        view.addSubview(nameRuLabel)
        view.addSubview(nameOriginalLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(strYearLabel)
        view.addSubview(intYearLabel)
        view.addSubview(strTimeLabel)
        view.addSubview(intTimeLabel)
        view.addSubview(activityIndicator)
        
        bindView()
        bindViewModel()
    }

    private func setupConstraints() {
        ratingStackView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(32)
        }
        posterImage.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(200)
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(16)
        }
        nameRuLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).inset(-16)
            make.centerX.equalToSuperview()
        }
        nameOriginalLabel.snp.makeConstraints { make in
            make.top.equalTo(nameRuLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.top.equalTo(nameOriginalLabel.snp.bottom).inset(-16)
            make.left.equalToSuperview().inset(16)
        }
        strYearLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(16)
        }
        intYearLabel.snp.makeConstraints { make in
            make.top.equalTo(strYearLabel.snp.bottom)
            make.left.equalToSuperview().inset(16)
        }
        strTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(intYearLabel.snp.bottom).inset(-30)
            make.left.equalToSuperview().inset(16)
        }
        intTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(strTimeLabel.snp.bottom)
            make.left.equalToSuperview().inset(16)
        }
    }
}
