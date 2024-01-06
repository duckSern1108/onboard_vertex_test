//
//  PickerView.swift
//  Vertex5-Test
//
//  Created by Admin on 06/01/2024.
//

import SwiftUI

struct PickerView: UIViewRepresentable {
    var data: [[String]]
    @Binding var selections: [String]
    
    //makeCoordinator()
    func makeCoordinator() -> PickerView.Coordinator {
        Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<PickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator

        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<PickerView>) {
        for i in 0...(self.selections.count - 1) {
            let _selection = self.selections[i]
            let _data = self.data[i]
            view.selectRow(_data.firstIndex(of: _selection) ?? 0, inComponent: i, animated: false)
        }
        context.coordinator.parent = self // fix
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: PickerView
        var maxWidthPercomponent: [CGFloat] = []
        var selectedFont = UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        //init(_:)
        init(_ pickerView: PickerView) {
            self.parent = pickerView
            
            var _maxWidthPercomponent: [CGFloat] = []
            parent.data.forEach { _componentData in
                let maxValue = _componentData.reduce("", {
                    if $0.count > $1.count {
                        return $0
                    } else {
                        return $1
                    }
                })
                let _width = NSString(string: maxValue).size(withAttributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .semibold)
                ]).width + 4
                _maxWidthPercomponent.append(_width)
            }
            self.maxWidthPercomponent = _maxWidthPercomponent
        }
        
        //numberOfComponents(in:)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            maxWidthPercomponent[component]
        }
        
        //pickerView(_:numberOfRowsInComponent:)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }
        
        //pickerView(_:titleForRow:forComponent:)
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[component][row]
        }
        
        //pickerView(_:didSelectRow:inComponent:)
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let _data = self.parent.data[component]
            self.parent.selections[component] = _data[row]
            pickerView.reloadComponent(component)
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let _data = self.parent.data[component][row]
            let _selection = self.parent.selections[component]
            let isSelected = _data == _selection
            
            let pickerLabel: UILabel = (view as? UILabel) ?? UILabel()
            pickerLabel.textAlignment = .center
            pickerLabel.font = isSelected ? selectedFont : UIFont.systemFont(ofSize: 20, weight: .medium)
            pickerLabel.text = self.parent.data[component][row]
            pickerLabel.textColor = isSelected ? UIColor.black : UIColor.black.withAlphaComponent(0.35)

            return pickerLabel
        }
    }
}

