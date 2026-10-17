
controladdin "ERF SFTT Scanner"
{
    RequestedHeight = 60;
    RequestedWidth = 500;
    MinimumHeight = 50;
    MinimumWidth = 300;


    Scripts = 'src/ERFSFTTScanner.js';
    StartupScript = 'src/ERFSFTTScannerStartup.js';

    event ControlAddInReady();
    event BarcodeScanned(Barcode: Text);

    procedure ClearInputs();
}
