//
//  MainCellView.swift
//  MVVM
//
//  Created by Nikita Beglov on 25.06.2024.
//

import UIKit
import SnapKit

final class MainCellView: UITableViewCell {

    static let mainCellIdentifire = Constants.identifire
    private lazy var nameLabel = UILabel()
    private lazy var posterImageView = UIImageView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.layoutMargins =  UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .systemGray4
        stackView.layer.borderColor = UIColor.label.cgColor
        stackView.layer.cornerRadius = 10
        nameLabel.numberOfLines = 0
        return stackView
    }()

    override init(style: MainCellView.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: MainCellView.mainCellIdentifire)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: MainCellModel) {
        nameLabel.text = viewModel.nameRu
        if let url = viewModel.posterImage {
            posterImageView.load(url: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
}

private extension MainCellView {

    func setupView() {
        contentView.addSubview(stackView)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(17)
        }
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(90)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
}

private enum Constants {
    static let identifire = "MainCell"
}
