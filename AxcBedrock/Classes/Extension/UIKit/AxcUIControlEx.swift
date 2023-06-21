//
//  AxcUIControlEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIControl { }

// MARK: - 类方法

public extension AxcSpace where Base: UIControl { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIControl { }

// MARK: - 扩展AxcSpaceStruct + AxcActionBlockProtocol

public extension AxcSpace where Base: UIControl {
    /// 触发事件Block
    /// - Parameters:
    ///   - event: 事件类型
    ///   - actionBlock: 回调
    func addEvent(_ event: UIControl.Event = .touchUpInside, actionBlock: @escaping AxcBlock.Action<Base>)
    {
        base._addEventBlock(event) { sender in
            guard let action = sender as? Base else { return }
            actionBlock(action)
        }
    }

    /// 移除响应事件
    /// - Parameters:
    ///   - event: 事件类型
    func removeEvent(_ event: UIControl.Event) {
        if let sel = base._getTargetSelector(event: event) {
            base.removeTarget(self, action: sel, for: event)
        }
    }
}

// MARK: - 扩展UIControl + AxcActionBlockProtocol

extension UIControl: AxcActionBlockTarget {
    public typealias ActionType = UIControl
    /// 触发事件Block
    fileprivate func _addEventBlock(_ event: UIControl.Event,
                                    actionBlock: @escaping AxcBlock.Action<ActionType>) {
        if let sel = _getTargetSelector(event: event) {
            let key = event.rawValue.axc.string
            setActionBlock(key: key, actionBlock)
            addTarget(self, action: sel, for: event)
        }
    }

    func _getTargetSelector(event: UIControl.Event) -> Selector? {
        var sel: Selector?
        if #available(iOS 14.0, *) {
            switch event {
            case .menuActionTriggered:
                sel = #selector(self._menuActionTriggeredAction)
            default: break
            }
        }
        switch event {
        case .touchDown:
            sel = #selector(self._touchDownAction)
        case .touchDownRepeat:
            sel = #selector(self._touchDownRepeatAction)
        case .touchDragInside:
            sel = #selector(self._touchDragInsideAction)
        case .touchDragOutside:
            sel = #selector(self._touchDragOutsideAction)
        case .touchDragEnter:
            sel = #selector(self._touchDragEnterAction)
        case .touchDragExit:
            sel = #selector(self._touchDragExitAction)
        case .touchUpInside:
            sel = #selector(self._touchUpInsideAction)
        case .touchUpOutside:
            sel = #selector(self._touchUpOutsideAction)
        case .touchCancel:
            sel = #selector(self._touchCancelAction)
        case .valueChanged:
            sel = #selector(self._valueChangedAction)
        case .primaryActionTriggered:
            sel = #selector(self._primaryActionTriggeredAction)
        case .editingDidBegin:
            sel = #selector(self._editingDidBeginAction)
        case .editingChanged:
            sel = #selector(self._editingChangedAction)
        case .editingDidEnd:
            sel = #selector(self._editingDidEndAction)
        case .editingDidEndOnExit:
            sel = #selector(self._editingDidEndOnExitAction)
        case .allTouchEvents:
            sel = #selector(self._allTouchEventsAction)
        case .allEditingEvents:
            sel = #selector(self._allEditingEventsAction)
        case .applicationReserved:
            sel = #selector(self._applicationReservedAction)
        case .systemReserved:
            sel = #selector(self._systemReservedAction)
        case .allEvents:
            sel = #selector(self._allEventsAction)
        default: break
        }
        return sel
    }

    /// 触发的方法
    func _controlAction(_ event: UIControl.Event) {
        let key = event.rawValue.axc.string
        guard let block = getActionBlock(key) else { return }
        block(self)
    }
}

extension UIControl {
    @objc
    func _touchDownAction() {
        _controlAction(.touchDown)
    }

    @objc
    func _touchDownRepeatAction() {
        _controlAction(.touchDownRepeat)
    }

    @objc
    func _touchDragInsideAction() {
        _controlAction(.touchDragInside)
    }

    @objc
    func _touchDragOutsideAction() {
        _controlAction(.touchDragOutside)
    }

    @objc
    func _touchDragEnterAction() {
        _controlAction(.touchDragEnter)
    }

    @objc
    func _touchDragExitAction() {
        _controlAction(.touchDragExit)
    }

    @objc
    func _touchUpInsideAction() {
        _controlAction(.touchUpInside)
    }

    @objc
    func _touchUpOutsideAction() {
        _controlAction(.touchUpOutside)
    }

    @objc
    func _touchCancelAction() {
        _controlAction(.touchCancel)
    }

    @objc
    func _valueChangedAction() {
        _controlAction(.valueChanged)
    }

    @available(iOS 9.0, *)
    @objc
    func _primaryActionTriggeredAction() {
        _controlAction(.primaryActionTriggered)
    }

    @available(iOS 14.0, *)
    @objc
    func _menuActionTriggeredAction() {
        _controlAction(.menuActionTriggered)
    }

    @objc
    func _editingDidBeginAction() {
        _controlAction(.editingDidBegin)
    }

    @objc
    func _editingChangedAction() {
        _controlAction(.editingChanged)
    }

    @objc
    func _editingDidEndAction() {
        _controlAction(.editingDidEnd)
    }

    @objc
    func _editingDidEndOnExitAction() {
        _controlAction(.editingDidEndOnExit)
    }

    @objc
    func _allTouchEventsAction() {
        _controlAction(.allTouchEvents)
    }

    @objc
    func _allEditingEventsAction() {
        _controlAction(.allEditingEvents)
    }

    @objc
    func _applicationReservedAction() {
        _controlAction(.applicationReserved)
    }

    @objc
    func _systemReservedAction() {
        _controlAction(.systemReserved)
    }

    @objc
    func _allEventsAction() {
        _controlAction(.allEvents)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UIControl { }

#endif
