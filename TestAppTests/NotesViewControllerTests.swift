//
//  NotesViewControllerTests.swift
//  TestAppTests
//
//  Created by Humberto Gutierrez on 2019-04-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import XCTest
@testable import TestApp

class NotesViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TableViewItemsCountIsEqualToDataSourceItemCount() {
        let vc = NotesViewController()
        _ = vc.view
        
        let tableViewNumberOfItems = vc.tableView.numberOfRows(inSection: 0)
        let dataSourceNumberOfItems = vc.presenter?.count
        
        XCTAssertEqual(tableViewNumberOfItems, dataSourceNumberOfItems)
    }
}
