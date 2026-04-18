{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      profiles.default.userSettings = {
        "chat.viewSessions.orientation" = "stacked";
        "diffEditor.experimental.showMoves" = true;
        "diffEditor.ignoreTrimWhitespace" = false;
        "diffEditor.renderSideBySide" = true;
        "editor.acceptSuggestionOnCommitCharacter" = false;
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.allowVariableFonts" = false;
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.emptySelectionClipboard" = false;
        "editor.fontFamily" = "'Google Sans Code','Maple Mono NL NF CN', Menlo, Monaco, 'Courier New', monospace";
        "editor.fontSize" = 20;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.linkedEditing" = true;
        "editor.minimap.renderCharacters" = false;
        "editor.renderControlCharacters" = true;
        "editor.renderWhitespace" = "boundary";
        "editor.stickyScroll.enabled" = true;
        "editor.stickyScroll.scrollWithEditor" = true;
        "editor.tabSize" = 2;
        "editor.unicodeHighlight.allowedLocales" = {
          "zh-hans" = true;
          "zh-hant" = true;
        };
        "editor.wordWrap" = "bounded";
        "editor.wordWrapColumn" = 120;
        "emmet.triggerExpansionOnTab" = true;
        "explorer.confirmDelete" = false;
        "extensions.closeExtensionDetailsOnViewChange" = true;
        "extensions.ignoreRecommendations" = true;
        "files.autoSave" = "off";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "git.allowForcePush" = true;
        "git.confirmSync" = false;
        "git.ignoreRebaseWarning" = true;
        "github.copilot.nextEditSuggestions.enabled" = true;
        "telemetry.feedback.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.fontFamily" = "Google Sans Code";
        "terminal.integrated.fontSize" = 16;
        "terminal.integrated.initialHint" = false;
        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "window.commandCenter" = false;
        "workbench.colorTheme" = "One Dark Pro";
        "workbench.editor.enablePreview" = false;
        "workbench.editor.splitInGroupLayout" = "vertical";
        "workbench.enableExperiments" = false;
        "workbench.layoutControl.enabled" = false;
        "workbench.settings.enableNaturalLanguageSearch" = false;
        "workbench.startupEditor" = "none";
      };
    };
  };
}
