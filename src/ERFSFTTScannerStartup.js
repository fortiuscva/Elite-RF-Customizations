
(function () {
    createScannerUI();

    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        "ControlAddInReady",
        [],
        false
    );
})();
