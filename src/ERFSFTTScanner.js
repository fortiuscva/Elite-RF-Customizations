
var barcodeInput;
var scanTimer = null;
var scannerRoot;

function createScannerUI() {
    var container = document.getElementById("controlAddIn");

    if (!container) {
        console.error(
            "ERF SFTT Scanner: controlAddIn container not found."
        );
        return;
    }

    if (scannerRoot && container.contains(scannerRoot)) {
        focusBarcodeInput();
        return;
    }

    scannerRoot = document.createElement("div");

    scannerRoot.innerHTML = `
        <style>
            .sftt-row {
                display: flex;
                align-items: center;
                width: 100%;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            .sftt-row label {
                width: 145px;
                flex: 0 0 145px;
                margin: 0;
                padding: 0;
                font-family: "Segoe UI", sans-serif;
                font-size: 14px;
                font-weight: normal;
                line-height: 32px;
                white-space: nowrap;
                box-sizing: border-box;
            }

            .sftt-row input {
                width: 305px;
                flex: 0 0 305px;
                min-width: 0;
                height: 32px;
                margin: 0;
                padding: 0 8px;
                border: 1px solid #8a8a8a;
                border-radius: 0;
                background-color: #ffffff;
                color: #242424;
                box-sizing: border-box;
                font-family: "Segoe UI", sans-serif;
                font-size: 14px;
                font-weight: normal;
            }
        </style>

        <div class="sftt-row">
            <label for="sfttBarcode">Scan Operation Code</label>
            <input
                id="sfttBarcode"
                type="text"
                aria-label="Scan Operation Code"
                autocomplete="off"
                spellcheck="false"
            />
        </div>
    `;

    container.appendChild(scannerRoot);

    barcodeInput = scannerRoot.querySelector("#sfttBarcode");

    barcodeInput.addEventListener("input", function () {
        clearTimeout(scanTimer);

        scanTimer = setTimeout(function () {
            var barcode = barcodeInput.value.trim();

            if (!barcode)
                return;

            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
                "BarcodeScanned",
                [barcode],
                false
            );

            barcodeInput.value = "";
        }, 250);
    });

    // Focus the barcode control after rendering.
    focusBarcodeInput();
}

function focusBarcodeInput() {
    if (!barcodeInput)
        return;

    requestAnimationFrame(function () {
        barcodeInput.focus();
        barcodeInput.select();
    });
}

function ClearInputs() {
    clearTimeout(scanTimer);

    if (!barcodeInput)
        return;

    barcodeInput.value = "";
    focusBarcodeInput();
}
