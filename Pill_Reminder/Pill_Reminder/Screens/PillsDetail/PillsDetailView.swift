//
//  PillsDetailView.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 29.05.24.
//

import UIKit

class PillsDetailView: UIViewController {
    private lazy var pillImageView = makeImageView()
    private lazy var pillLabel = makePillLabel()
    private lazy var progressLabel = makePillProgressLabel()
    private lazy var pillProgressLine = makePillProgressLine()
    
    private var presenter: PillsDetailPresenter
    
    init(presenter: PillsDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setup()
        
    }
    
}

private extension PillsDetailView {
    
    func setup() {
        pillLabel.text = presenter.getTitle()
        progressLabel.text = presenter.getDescription() // посмотреть прогресс
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        pinImageView()
        pinPillLabel()
        pinProgressLabel()
        pinProgressLine()
    }
    
    func pinImageView() {
        view.addSubview(pillImageView)
        NSLayoutConstraint.activate([
            pillImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            pillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pillImageView.widthAnchor.constraint(equalTo: pillImageView.heightAnchor, multiplier: 1),
            pillImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func pinPillLabel() {
        view.addSubview(pillLabel)
        NSLayoutConstraint.activate([
            pillLabel.topAnchor.constraint(equalTo: pillImageView.bottomAnchor, constant: 16),
            pillLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            pillLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func pinProgressLabel() {
        view.addSubview(progressLabel)
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: pillLabel.bottomAnchor, constant: 16),
            progressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            progressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func pinProgressLine() {
        view.addSubview(pillProgressLine)
        NSLayoutConstraint.activate([
            pillProgressLine.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            pillProgressLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            pillProgressLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            pillProgressLine.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(UIImageView(image: UIImage(named: "pill")))
        return view
    }
    
    func makePillLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pill"
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }
    
    func makePillProgressLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Progress"
        
        return label
    }
    
    func makePillProgressLine() -> UIProgressView {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = .blue
        view.progress = 0.5
        
        return view
    }
    
    
}
