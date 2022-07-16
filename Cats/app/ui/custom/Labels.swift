//
//  Labels.swift
//  Cats
//
//  Created by 김태호 on 2022/07/15.
//

import SwiftUI

struct Labels: View {
    private let text: String
    private let foregoundColor: Color
    
    init(
        text: String,
        _ foregroundColor: Color = .accentColor
    ) {
        self.text = text
        self.foregoundColor = foregroundColor
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(self.foregoundColor)
            .frame(height: 50)
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
            )
    }
}

struct Labels_Previews: PreviewProvider {
    static let text = "Example"
    
    static var previews: some View {
        GroupBox {
            Group {
                HStack {
                    Labels(text: text)
                    Labels(text: text)
                }
            }
            Group {
                Labels(text: text)
            }
        }
        .previewLayout(.sizeThatFits)
        
        GroupBox {
            Group {
                HStack {
                    Labels(text: text)
                    Labels(text: text)
                }
            }
            Group {
                Labels(text: text)
            }
        }
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
