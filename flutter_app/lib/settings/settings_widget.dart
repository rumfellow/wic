import '../add_dicts/add_dicts_widget.dart';
import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../gptinstructions/gptinstructions_widget.dart';
import '../loginpage/loginpage_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  String dictionariesValue;
  TextEditingController textController1;
  TextEditingController textController2;
  String targetValue;
  String nativeValue;
  String stylesValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: currentUserEmail);
    textController2 = TextEditingController(text: FFAppState().gptKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E1D2A),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: AuthUserStreamWidget(
                    child: Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        currentUserPhoto,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          child: TextFormField(
                            controller: textController1,
                            autofocus: true,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                '1ib5hf8n' /* Email Address */,
                              ),
                              hintText: FFLocalizations.of(context).getText(
                                '6bvxrgfn' /* [Some hint text...] */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                        child: TextFormField(
                          controller: textController2,
                          onChanged: (_) => EasyDebounce.debounce(
                            'textController2',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'xgoyz4ks' /* GPT-3 API Key */,
                            ),
                            hintText: FFLocalizations.of(context).getText(
                              'njhmn9gi' /* [Some hint text...] */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: textController2.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      textController2?.clear();
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  )
                                : null,
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'l8dec08a' /* Available dictionaries */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      FlutterFlowDropDown(
                        initialOption: dictionariesValue ??=
                            FFAppState().currentDict,
                        options: FFAppState().dictList.toList(),
                        onChanged: (val) =>
                            setState(() => dictionariesValue = val),
                        width: 180,
                        height: 50,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                ),
                        hintText: FFLocalizations.of(context).getText(
                          'y6bp2uhj' /* Please select... */,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 0,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 4),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        '0dzaibsq' /* Foreign language: */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    FlutterFlowDropDown(
                      initialOption: targetValue ??= FFAppState().currentTarget,
                      options: FFAppState().langList.toList(),
                      onChanged: (val) => setState(() => targetValue = val),
                      width: 170,
                      height: 50,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                            fontFamily: 'Roboto',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                      hintText: FFLocalizations.of(context).getText(
                        'ib9andpf' /* Foreign language */,
                      ),
                      fillColor: Color(0xFF1E1D2A),
                      elevation: 0,
                      borderColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'yu1z2thy' /* Native language: */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    FlutterFlowDropDown(
                      initialOption: nativeValue ??= FFAppState().currentNative,
                      options: FFAppState().langList.toList(),
                      onChanged: (val) => setState(() => nativeValue = val),
                      width: 170,
                      height: 50,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                            fontFamily: 'Roboto',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                      hintText: FFLocalizations.of(context).getText(
                        '7oz1zh22' /* Native language */,
                      ),
                      fillColor: Color(0xFF1E1D2A),
                      elevation: 0,
                      borderColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'tib5trw0' /* Text generation styles */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    FlutterFlowDropDown(
                      initialOption: stylesValue ??=
                          FFLocalizations.of(context).getText(
                        '71z3wm2v' /* Normal */,
                      ),
                      options: FFAppState().styleList.toList(),
                      onChanged: (val) => setState(() => stylesValue = val),
                      width: 170,
                      height: 50,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                            fontFamily: 'Roboto',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                      hintText: FFLocalizations.of(context).getText(
                        's44verrc' /* Style */,
                      ),
                      fillColor: Color(0xFF1E1D2A),
                      elevation: 0,
                      borderColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      borderWidth: 2,
                      borderRadius: 8,
                      margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDictsWidget(),
                            ),
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'r3uzbk9t' /* Add/delete user dictionaries */,
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GptinstructionsWidget(),
                            ),
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'y31mbutt' /* GPT-3 registration & instructi... */,
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            width: 0,
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
                          setState(() =>
                              FFAppState().currentDict = dictionariesValue);
                          setState(
                              () => FFAppState().currentStyle = stylesValue);
                          setState(
                              () => FFAppState().currentNative = nativeValue);
                          setState(
                              () => FFAppState().currentTarget = targetValue);
                          setState(
                              () => FFAppState().gptKey = textController2.text);
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          'app5r6eb' /* Update settings/back */,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          color: Color(0xFF1E1D2A),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: Color(0xFF1E1D2A),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
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
                          await signOut();
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginpageWidget(),
                            ),
                            (r) => false,
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'f6gq3j56' /* Logout */,
                        ),
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: Color(0xFF1E1D2A),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: Color(0xFF1E1D2A),
                            width: 2,
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
