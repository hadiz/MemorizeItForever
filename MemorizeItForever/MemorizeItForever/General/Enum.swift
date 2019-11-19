//
//  Enum.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

enum CellReuseIdentifier: String{
    case setTableCellIdentifier = "SetTableCellIdentifier"
    case changeSetTableCellIdentifier = "ChangeSetTableCellIdentifier"
    case phraseTableCellIdentifier = "PhraseTableCellIdentifier"
    case phraseHistoryTableCellIdentifier = "PhraseHistoryTableCellIdentifier"
    case temporaryListTableIdentifier = "TemporaryListTableCellIdentifier"
    case depotTableCellIdentifier = "DepotTableCellIdentifier"
}
enum EntityMode: String{
    case save
    case edit
}
enum SwipeDirection{
    case left
    case right
    case up
    case down
}
enum CardViewPosition{
    case current
    case previous
    case next
}

enum SubViewsEnum: Int{
    case taskDoneView = 100001
}

enum TableRowAction: String {
    case add
    case edit
    case delete
}

enum TempPhrase: String {
    case original
    case edited
}
