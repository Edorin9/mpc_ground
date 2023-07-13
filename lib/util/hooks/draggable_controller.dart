// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class _DraggableScrollableControllerHookCreator {
//   const _DraggableScrollableControllerHookCreator();

//   DraggableScrollableController call({String? text, List<Object?>? keys}) {
//     return use(const _DraggableScrollableControllerHook());
//   }
// }

// const useDraggableScrollableController =
//     _DraggableScrollableControllerHookCreator();

// class _DraggableScrollableControllerHook
//     extends Hook<DraggableScrollableController> {
//   const _DraggableScrollableControllerHook([
//     List<Object?>? keys,
//   ]) : super(keys: keys);

//   @override
//   _DraggableScrollableControllerHookState createState() {
//     return _DraggableScrollableControllerHookState();
//   }
// }

// class _DraggableScrollableControllerHookState extends HookState<
//     DraggableScrollableController, _DraggableScrollableControllerHook> {
//   late final _controller = DraggableScrollableController();

//   @override
//   DraggableScrollableController build(BuildContext context) =>
//       DraggableScrollableController();

//   @override
//   void dispose() => _controller.dispose();

//   @override
//   String get debugLabel => 'useDraggableScrollableController';
// }
