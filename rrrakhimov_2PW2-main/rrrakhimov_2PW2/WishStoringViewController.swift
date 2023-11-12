// MARK: - WishStoringViewController
import UIKit

final class WishStoringViewController: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let tableCornerRadius: CGFloat = 10.0
    }
    
    // MARK: - Properties
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadWishes()
        configureTable()
    }

    // MARK: - Private Methods
    private func loadWishes() {
        if let wishes = UserDefaults.standard.object(forKey: "wishes") as? [String] {
            wishArray = wishes
        }
    }

    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .systemGroupedBackground
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return wishArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] wish in
                self?.addWish(wish)
                tableView.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: wishArray[indexPath.row], deleteAction: { [weak self] in
                self?.deleteWish(at: indexPath.row)
                
            })
            return cell
        }
    }
    
    
    
    // MARK: - Helpers
    private func addWish(_ wish: String) {
        wishArray.append(wish)
        UserDefaults.standard.set(wishArray, forKey: "wishes")
        table.reloadData()
    }

    private func deleteWish(at index: Int) {
        if index < wishArray.count {
            wishArray.remove(at: index)
            UserDefaults.standard.set(wishArray, forKey: "wishes")
            table.reloadData()
        }
    }


}
// MARK: - WrittenWishCell
final class WrittenWishCell: UITableViewCell {

    // MARK: - Properties
    static let reuseId = "WrittenWishCell"
    private let wishLabel = UILabel()
    private let deleteButton = UIButton(type: .system)
    private var deleteAction: (() -> Void)?

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    

    private func configureUI() {
        addSubview(wishLabel)
        addSubview(deleteButton)
        contentView.addSubview(deleteButton)

        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.tintColor = .red
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        // WishLabel Constraints
        NSLayoutConstraint.activate([
            wishLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            wishLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            wishLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            wishLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8)
        ])
        
        // DeleteButton Constraints
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            deleteButton.widthAnchor.constraint(equalToConstant: 75)
        ])
    }

    // MARK: - Actions
    @objc private func deleteWishTapped() {
        print("hi")
        deleteAction?()
    }
    func configure(with wish: String, deleteAction: @escaping () -> Void) {
            wishLabel.text = wish
            self.deleteAction = deleteAction
            deleteButton.addTarget(self, action: #selector(deleteWishTapped), for: .touchUpInside)
        }
}

// MARK: - AddWishCell
final class AddWishCell: UITableViewCell {

    // MARK: - Properties
    static let reuseId = "AddWishCell"
    var addWish: ((String) -> Void)?
    
    private let wishTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Wish", for: .normal)
        return button
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureUI() {

        contentView.addSubview(wishTextView)
        contentView.addSubview(addButton)

        NSLayoutConstraint.activate([
            wishTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            wishTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wishTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wishTextView.heightAnchor.constraint(equalToConstant: 100),
            
            addButton.topAnchor.constraint(equalTo: wishTextView.bottomAnchor, constant: 8),
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        addButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func addWishTapped() {
        if let text = wishTextView.text, !text.isEmpty {
            addWish?(text)
            wishTextView.text = ""
        }
    }
}
