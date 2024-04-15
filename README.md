
## OutSystems Developer Cloud (ODC) Custom Code Packaging Tool

This script helps OutSystems developers to easily publish their custom C# code for use in OutSystems Developer Cloud (ODC) apps. It automates the process of building, packaging, and preparing your custom code for upload to the ODC Portal.

![demo](https://raw.githubusercontent.com/kelter-antunes/OutSystems-ODC-Code-Packaging-Tool/main/img/example.gif)

### How to Use

1. **Place the Script in Your Project Directory**: Make sure the script (`generate_upload_package.ps1`) is located in the root directory of your OutSystems project.

2. **Run the Script**: Open PowerShell and navigate to your project directory. Run the script by typing `.\generate_upload_package.ps1`.

3. **Silent Mode**: If you want to run the script without any prompts, you can use the `-silent` or `-s` argument. For example, `.\generate_upload_package.ps1 -s`. This mode will automatically use the default settings and won't ask for any input.

4. **Upload to ODC Portal**: After running the script, a `.zip` file will be created in your project directory. This file contains your custom code, ready to be uploaded to the ODC Portal.

### Uploading to ODC Portal

- **Permission Required**: You need permission to create and change libraries in the ODC Portal. Speak to an administrator from your ODC organization to get the necessary permissions.
- **Upload the ZIP File**: Go to the ODC Portal and select "External Logic" from the left navigation menu. Click "Create library" to create a new external library or "Upload new revision" to update an existing one. Upload the `.zip` file you created with the script.
- **Review and Publish**: After uploading, review the file contents and fix any errors. Once everything is correct, click "Publish library" or "Publish revision" to make your custom code available in your ODC apps.

### Additional Information

- **Silent Mode**: The script can be run in silent mode by using the `-silent` or `-s` argument. This mode will not display any prompts and will use the default settings.
- **Support**: This script is designed to help with the process of publishing custom C# code to the ODC Portal. If you encounter any issues or have questions, please refer to the OutSystems documentation or contact OutSystems support.

### Disclaimer

This script is provided as-is and is intended for use by OutSystems developers. Always review and test scripts in a safe environment before using them in production.