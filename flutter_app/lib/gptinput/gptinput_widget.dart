import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../gptinstructions/gptinstructions_widget.dart';
import '../main/main_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GptinputWidget extends StatefulWidget {
  const GptinputWidget({Key key}) : super(key: key);

  @override
  _GptinputWidgetState createState() => _GptinputWidgetState();
}

class _GptinputWidgetState extends State<GptinputWidget> {
  ApiCallResponse generalsettings;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      generalsettings = await GetgeneralsettingsCall.call(
        uuid: currentUserUid,
        mytok: currentJwtToken,
      );
      setState(
          () => FFAppState().dictList = (GetgeneralsettingsCall.dictionaries(
                (generalsettings?.jsonBody ?? ''),
              ) as List)
                  .map<String>((s) => s.toString())
                  .toList()
                  .toList());
      setState(() => FFAppState().langList = (GetgeneralsettingsCall.languages(
            (generalsettings?.jsonBody ?? ''),
          ) as List)
              .map<String>((s) => s.toString())
              .toList()
              .toList());
      setState(() => FFAppState().styleList = (GetgeneralsettingsCall.styles(
            (generalsettings?.jsonBody ?? ''),
          ) as List)
              .map<String>((s) => s.toString())
              .toList()
              .toList());
      setState(() => FFAppState().startApp = false);
      setState(
          () => FFAppState().customDict = (GetgeneralsettingsCall.userDicts(
                (generalsettings?.jsonBody ?? ''),
              ) as List)
                  .map<String>((s) => s.toString())
                  .toList()
                  .toList());
      if (FFAppState().gptKey == null || FFAppState().gptKey == '') {
        return;
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainWidget(),
        ),
      );
    });

    textController = TextEditingController();
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 0),
                  child: SvgPicture.network(
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/firebtest-im2vcp/assets/z88x1uxgzf6h/white_ae.svg',
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(-0.15, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 130, 22, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'jpksrffm' /* Words in context uses GPT-3 ar... */,
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 15, 12, 0),
                        child: TextFormField(
                          controller: textController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'textController',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: FFLocalizations.of(context).getText(
                              'h1pz2mnc' /* Please paste GPT-3 API key */,
                            ),
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            suffixIcon: textController.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      textController?.clear();
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
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(-0.85, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        setState(
                            () => FFAppState().gptKey = textController.text);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainWidget(),
                          ),
                        );
                      },
                      text: FFLocalizations.of(context).getText(
                        'a63lodh9' /* Continue */,
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
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '2ki8msc8' /* See the instructions how to ge... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(-0.87, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
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
                            'yaspb5fp' /* Instructions */,
                          ),
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Roboto',
                                      color: Colors.white,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
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
