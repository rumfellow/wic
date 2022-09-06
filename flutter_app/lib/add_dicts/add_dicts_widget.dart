import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDictsWidget extends StatefulWidget {
  const AddDictsWidget({Key key}) : super(key: key);

  @override
  _AddDictsWidgetState createState() => _AddDictsWidgetState();
}

class _AddDictsWidgetState extends State<AddDictsWidget> {
  ApiCallResponse generalsettings1;
  String targetValue;
  ApiCallResponse generalsettings;
  String langValue;
  TextEditingController dictnameController;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dictnameController = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 30,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          'bcxuyxpj' /* Add/delete dictionaries */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'gd7urc3b' /* Add words to your personal dic... */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'dozhszdo' /* Dictionary name: */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      Container(
                        width: 170,
                        child: TextFormField(
                          controller: dictnameController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: FFLocalizations.of(context).getText(
                              'sovrbmwi' /* Dictionary name */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '8f9iurt7' /* Dictionary language: */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      FlutterFlowDropDown(
                        initialOption: langValue ??= FFAppState().currentDict,
                        options: FFAppState().langList.toList(),
                        onChanged: (val) => setState(() => langValue = val),
                        width: 180,
                        height: 50,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: 'Roboto',
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          '03wy60mc' /* Please select... */,
                        ),
                        fillColor: Color(0xFF1E1D2A),
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 0,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'dqeffi13' /* Please input your words, comma... */,
                            ),
                            textAlign: TextAlign.start,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: textController2,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: FFLocalizations.of(context).getText(
                                'rv2ij9ut' /* Your word, another word, third... */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          var _shouldSetState = false;
                          if (dictnameController.text == null ||
                              dictnameController.text == '') {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Empty field'),
                                  content:
                                      Text('Dictionary field can not be empty'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (_shouldSetState) setState(() {});
                            return;
                          } else {
                            if (textController2.text == null ||
                                textController2.text == '') {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Empty list'),
                                    content:
                                        Text('Words list can not be empty'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) setState(() {});
                              return;
                            } else {
                              if (langValue == null || langValue == '') {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Set language'),
                                      content: Text(
                                          'Language field cannot be empty'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (_shouldSetState) setState(() {});
                                return;
                              } else {
                                await Future.delayed(
                                    const Duration(milliseconds: 10));
                              }

                              generalsettings =
                                  await GetgeneralsettingsCall.call(
                                uuid: currentUserUid,
                                mytok: currentJwtToken,
                              );
                              _shouldSetState = true;
                              await AddDictsCall.call(
                                uuid: currentUserUid,
                                trans: langValue,
                                words: textController2.text,
                                dictionary: dictnameController.text,
                                mytok: currentJwtToken,
                              );
                              // updateCustomDictsVar
                              setState(() => FFAppState().customDict =
                                      (GetgeneralsettingsCall.userDicts(
                                    (generalsettings?.jsonBody ?? ''),
                                  ) as List)
                                          .map<String>((s) => s.toString())
                                          .toList());
                              // updateDictListVar
                              setState(() => FFAppState().dictList =
                                      (GetgeneralsettingsCall.dictionaries(
                                    (generalsettings?.jsonBody ?? ''),
                                  ) as List)
                                          .map<String>((s) => s.toString())
                                          .toList());
                              setState(() {
                                textController2?.clear();
                              });
                            }
                          }

                          if (_shouldSetState) setState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'awy7pfnv' /* Update/create dictionary */,
                        ),
                        icon: Icon(
                          Icons.add_box_outlined,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          color: Color(0xFF1E1D2A),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Color(0xFF1E1D2A),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'l43hxkdh' /* Delete  your personal dictiona... */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          await DeldictsCall.call(
                            action: 'deldict',
                            userdict: targetValue,
                            uuid: currentUserUid,
                            mytok: currentJwtToken,
                          );
                          generalsettings1 = await GetgeneralsettingsCall.call(
                            uuid: currentUserUid,
                            mytok: currentJwtToken,
                          );
                          // updateDictListVar
                          setState(() => FFAppState().dictList =
                                  (GetgeneralsettingsCall.dictionaries(
                                (generalsettings1?.jsonBody ?? ''),
                              ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList());
                          // updateCustomDictsVar
                          setState(() => FFAppState().customDict =
                                  (GetgeneralsettingsCall.userDicts(
                                (generalsettings1?.jsonBody ?? ''),
                              ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList());

                          setState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'q4uttvhx' /* Delete  */,
                        ),
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          color: Color(0xFF1E1D2A),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Color(0xFF1E1D2A),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FlutterFlowDropDown(
                        initialOption: targetValue ??=
                            FFLocalizations.of(context).getText(
                          '4n6y2agz' /* Personal dict */,
                        ),
                        options: FFAppState().customDict.toList(),
                        onChanged: (val) => setState(() => targetValue = val),
                        width: 170,
                        height: 40,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: 'Roboto',
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          'z542txof' /* User dictionaries */,
                        ),
                        fillColor: Color(0xFF1E1D2A),
                        elevation: 0,
                        borderColor: Color(0xFF1E1D2A),
                        borderWidth: 2,
                        borderRadius: 8,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'ndiia25y' /* Delete all liked phrases: */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          await DeldictsCall.call(
                            uuid: currentUserUid,
                            action: 'purge',
                            userdict: 'notspecified',
                            mytok: currentJwtToken,
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          's27wqdv5' /* Purge */,
                        ),
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          color: Color(0xFF1E1D2A),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Color(0xFF1E1D2A),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
