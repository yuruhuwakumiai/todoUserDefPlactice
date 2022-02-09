//
//  ViewController.swift
//  ToDoList
//
//  Created by 橋元雄太郎 on 2022/02/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    // この配列を主に使用していく
    var todoList = [String]()

    // インスタンスの生成 これで、UserDefaultsというローカルにデータを保存するインターフェイスを使えるようになる
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // tableViewCellカスタムセルの登録
        todoTableView.register(UINib(nibName: Identifier.tableviewClassName, bundle: nil), forCellReuseIdentifier: Identifier.tableViewCellId)

        // 追記：データ読み込み
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todoList.append(contentsOf: storedTodoList)
        }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // NavigationBarの背景色の設定
        appearance.backgroundColor = UIColor.systemGreen
        // NavigationBarのタイトルの文字色の設定
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @IBAction func todoActionbutton(_ sender: Any) {
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを入力してください。", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (acrion: UIAlertAction) in
            //OKをタップした時の処理
            if let textField = alertController.textFields?.first {
                self.todoList.insert(textField.text!, at: 0)
                self.todoTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)

                // 追加したToDoを保存
                self.userDefaults.set(self.todoList, forKey: "todoList")
            }
        }
        alertController.addAction(okAction)
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: Identifier.tableViewCellId, for: indexPath) as! TableViewCell
        let todoTitle = todoList[indexPath.row]
        cell.todoLabel.text = todoTitle
        return cell
    }

    // 追加：セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todoList.remove(at: indexPath.row)
            todoTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)

            //削除した内容を保存
            userDefaults.set(todoList, forKey: "todoList")
        }
    }
}

