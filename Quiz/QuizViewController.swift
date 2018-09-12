//
//  QuizViewController.swift
//  Quiz
//
//  Created by Maho Misumi on 2018/08/31.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //正解数
    var correctAnswer: Int = 0
    
    //問題文を格納する配列
    var quizArray = [Any]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.

        var tmpArray = [Any]()
        
        //tmpArrayに問題文、三つの選択肢、答えの番号が入った配列を追加していく
        
        tmpArray.append(["喜びの舞","おはよう","お休み","こんにちは",1])
        tmpArray.append(["嬉しい","おはよう","お休み","こんにちは",1])
        tmpArray.append(["喜ぶ","おはよう","お休み","こんにちは",1])
        tmpArray.append(["感動する","おはよう","お休み","こんにちは",1])
        tmpArray.append(["舞う","おはよう","お休み","こんにちは",1])
        tmpArray.append(["うふふ","おはよう","お休み","こんにちは",1])
        
        //問題文をシャッフルしてquizArrayに格納する
        while(tmpArray.count > 0){
            let index = Int(arc4random()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.remove(at: index)
        }
        choiceQuiz()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func choiceQuiz(){
        //一時的にクイズを取り出す配列
        let tmpArray = quizArray[0] as! [Any]
        
        //問題文のテキストを表示
        quizTextView.text = tmpArray[0] as! String
        
        //選択肢のボタンにそれぞれの選択肢のテキストをセット
        choiceButton1.setTitle(tmpArray[1] as? String, for: .normal)
        choiceButton2.setTitle(tmpArray[2] as? String, for: .normal)
        choiceButton3.setTitle(tmpArray[3] as? String, for: .normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton){
        
        let tmpArray = quizArray[0] as! [Any]
        
        if tmpArray[4] as! Int == sender.tag{
            
            //正解数を増やす
            correctAnswer = correctAnswer + 1
            print(correctAnswer)
        }
        
    //解いた問題をquizArrayから取り除く
        quizArray.remove(at: 0)
        
    //解いた問題数の合計があらかじめ設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else{
            choiceQuiz()
        }
    }
    
    func performSegueToResult(){
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    
    //セグエを準備(prepare)するときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destination as! resultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
