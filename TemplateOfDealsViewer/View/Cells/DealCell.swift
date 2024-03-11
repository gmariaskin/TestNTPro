import UIKit

class DealCell: UITableViewCell {
    
  static let reuseIidentifier = "DealCell"
  
  @IBOutlet weak var instrumentNameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var sideLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with deal: Deal) {
        
        self.dateLabel.text = String(deal.dateModifier.formatted())
        self.priceLabel.text = String(deal.price.roundToDecimal(2))
        self.amountLabel.text = String(Int(deal.amount))
        
        switch deal.side {
        case .buy:
            self.sideLabel.textColor = .green
            self.priceLabel.textColor = .green
            self.sideLabel.text = "Buy"
        case .sell: 
            self.sideLabel.textColor = .red
            self.priceLabel.textColor = .red
            self.sideLabel.text = "Sell"
        }
    }

}


