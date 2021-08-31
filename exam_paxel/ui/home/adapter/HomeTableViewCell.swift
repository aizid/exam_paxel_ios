import UIKit

protocol SeeDetails{
    func showDetails(_: HomeTableViewCell, id:Int?)
}

class HomeTableViewCell: UITableViewCell {
    
    var delegate: SeeDetails?
    
    @IBOutlet weak var tvItemNotifLabel: UILabel!
    @IBOutlet weak var ivItemNotifImage: UIImageView!
    @IBOutlet weak var tvItemAttribut: UILabel!
    @IBOutlet weak var tvItemType: UILabel!
    
    var repoId: Int = 0
    var position: Int = 0
    
    func setData(data: Item, position: Int) {
        repoId = data.id!
        self.position = position
        
        tvItemNotifLabel.text = data.full_name
        tvItemAttribut.text = data.owner?.login
        tvItemType.text = data.description
        
        let image: String? = GlobalFunc.CHECK_STRING_EMPTY_NULL(value: data.owner?.avatar_url)
        if image != nil && !image!.isEmpty {
            let imgUrl = URL(string: image!)!
            ivItemNotifImage.load(url: imgUrl)
        }
    }
    
    @IBAction func btnSeeDetails(_ sender: Any) {
        if repoId != 0 {
            self.delegate?.showDetails(self, id: position)
        }
    }
    
}
