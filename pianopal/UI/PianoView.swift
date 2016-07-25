//
//  PianoView.swift
//  pianopal
//
//  Created by Joshua Escribano on 7/23/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import UIKit

class PianoView: UIView, UIScrollViewDelegate {
    var scrollView: UIScrollView?
    var noteButtons = [NoteButton]()
    var highlightedNoteButtons = [NoteButton]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        scrollView = UIScrollView(frame: Dimensions.pianoScrollRect)
        scrollView!.maximumZoomScale = 1
        scrollView!.minimumZoomScale = 1
        scrollView!.contentSize.width = scrollView!.frame.width * 3
        scrollView!.contentSize.height = scrollView!.frame.height
        scrollView!.contentOffset = CGPoint(x: scrollView!.frame.width, y: 0)
        scrollView!.showsVerticalScrollIndicator = false
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.decelerationRate = 0.98
        scrollView!.bounces = false
        scrollView!.delegate = self
    }
    
    override func layoutSubviews() {
        scrollView!.addSubview(setUpOctaveView(2))
        scrollView!.addSubview(setUpOctaveView(1))
        scrollView!.addSubview(setUpOctaveView(0))
        addSubview(scrollView!)
    }
    
    func setUpOctaveView(position: Int) -> UIView {
        let height = scrollView!.frame.height
        let width = scrollView!.frame.width
        let offset = CGFloat(position) * scrollView!.frame.width
        let octaveView = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        for note in Constants.orderedNotes {
            let buttonFrame = CGRect(x: width * KeyProperties.x(note), y: 0, width: width * KeyProperties.width(note), height: height * KeyProperties.height(note))
            let button = NoteButton(frame: buttonFrame, note: note)
            noteButtons.append(button)
            octaveView.addSubview(button)
        }
        return octaveView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case scrollView.frame.width * 2, 0:
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: false)
            break
        default:
            break
        }
    }
}
