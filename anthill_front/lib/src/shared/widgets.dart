library shared_widgets;

export 'application/providers/share_link_provider.dart' show shareLinkProvider;
export 'presentation/app.dart' show AnthillApp;
export 'presentation/dialogs/confirmation_dialog.dart' show ConfirmationDialog, askUserConfirmation;
export 'presentation/form_defaults.dart'
    show defaultFormPadding, formHeightFraction, verticalFormPadding, horizontalFormPadding;
export 'presentation/widgets/copy_link_button.dart' show CopyLinkButton;
export 'presentation/widgets/error_notice.dart' show ErrorNotice;
export 'presentation/widgets/model_info_chips.dart' show ModelInfoChips;
export 'presentation/widgets/page_body.dart' show PageBody;
export 'presentation/widgets/progress_indicator_button.dart' show ProgressIndicatorButton;
export 'presentation/widgets/resource_card.dart' show ResourceCard;
export 'presentation/widgets/single_model_controls.dart' show SingleModelControls;
export 'presentation/widgets/snack_bar_content.dart' show SnackBarContent, showSnackBar;
export 'presentation/widgets/switch_single_model_value.dart' show switchSingleModelValue;
export 'utils/date_format.dart' show formatDate;
export 'utils/if_has_roles.dart' show ifHasRoles;
export 'utils/validators.dart' show isRequired, isPassword, isAmount;
