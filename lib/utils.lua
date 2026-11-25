local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1
L0_1 = IsDuplicityVersion
L0_1 = L0_1()
SERVER = L0_1
L0_1 = SERVER
L0_1 = not L0_1
CLIENT = L0_1
L0_1 = GetCurrentResourceName
L0_1 = L0_1()
L1_1 = SERVER
if L1_1 then
  function L1_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = type
    L1_2 = package
    L0_2 = L0_2(L1_2)
    L0_2 = "table" == L0_2
    return L0_2
  end
  L2_1 = L1_1
  L2_1 = L2_1()
  L2_1 = not L2_1
  L3_1 = L1_1
  L3_1 = L3_1()
  if L3_1 then
    L3_1 = os
    L3_1 = L3_1.getenv
    L4_1 = "ANSICON"
    L3_1 = L3_1(L4_1)
    L2_1 = L3_1
  end
  L3_1 = {}
  L3_1.reset = 0
  L3_1.bright = 1
  L3_1.dim = 2
  L3_1.underline = 4
  L3_1.blink = 5
  L3_1.reverse = 7
  L3_1.hidden = 8
  L3_1.black = 30
  L3_1.red = 31
  L3_1.green = 32
  L3_1.yellow = 33
  L3_1.blue = 34
  L3_1.magenta = 35
  L3_1.cyan = 36
  L3_1.white = 37
  L3_1.blackbg = 40
  L3_1.redbg = 41
  L3_1.greenbg = 42
  L3_1.yellowbg = 43
  L3_1.bluebg = 44
  L3_1.magentabg = 45
  L3_1.cyanbg = 46
  L3_1.whitebg = 47
  L4_1 = string
  L4_1 = L4_1.char
  L5_1 = 27
  L4_1 = L4_1(L5_1)
  L5_1 = "[%dm"
  L4_1 = L4_1 .. L5_1
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = L4_1
    L2_2 = L1_2
    L1_2 = L1_2.format
    L3_2 = A0_2
    return L1_2(L2_2, L3_2)
  end
  function L6_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L1_2 = L2_1
    if not L1_2 then
      L1_2 = ""
      return L1_2
    end
    L1_2 = {}
    L2_2 = nil
    L4_2 = A0_2
    L3_2 = A0_2.gmatch
    L5_2 = "%w+"
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
    for L7_2 in L3_2, L4_2, L5_2, L6_2 do
      L8_2 = L3_1
      L2_2 = L8_2[L7_2]
      L8_2 = assert
      L9_2 = L2_2
      L10_2 = "Unknown key: "
      L11_2 = L7_2
      L10_2 = L10_2 .. L11_2
      L8_2(L9_2, L10_2)
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L5_1
      L11_2 = L2_2
      L10_2 = L10_2(L11_2)
      L8_2(L9_2, L10_2)
    end
    L3_2 = table
    L3_2 = L3_2.concat
    L4_2 = L1_2
    return L3_2(L4_2)
  end
  function L7_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = string
    L1_2 = L1_2.gsub
    L2_2 = A0_2
    L3_2 = "(%%{(.-)})"
    function L4_2(A0_3, A1_3)
      local L2_3, L3_3
      L2_3 = L6_1
      L3_3 = A1_3
      return L2_3(L3_3)
    end
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    A0_2 = L1_2
    return A0_2
  end
  function L8_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = tostring
    L2_2 = A0_2 or L2_2
    if not A0_2 then
      L2_2 = ""
    end
    L1_2 = L1_2(L2_2)
    A0_2 = L1_2
    L1_2 = L7_1
    L2_2 = "%{reset}"
    L3_2 = A0_2
    L4_2 = "%{reset}"
    L2_2 = L2_2 .. L3_2 .. L4_2
    return L1_2(L2_2)
  end
  L9_1 = utf8
  if not L9_1 then
    L9_1 = require
    L10_1 = "compat53.module"
    L9_1 = L9_1(L10_1)
    L9_1 = L9_1.utf8
  end
  L10_1 = {}
  L11_1 = {}
  L12_1 = setmetatable
  L13_1 = {}
  L13_1.noReset = L7_1
  L14_1 = {}
  function L15_1(A0_2, A1_2)
    local L2_2, L3_2
    L2_2 = L8_1
    L3_2 = A1_2
    return L2_2(L3_2)
  end
  L14_1.__call = L15_1
  L12_1 = L12_1(L13_1, L14_1)
  L13_1 = {}
  L13_1.NW = "/"
  L13_1.NE = "\\"
  L13_1.SW = "\\"
  L13_1.SE = "/"
  L13_1.N = "+"
  L13_1.S = "+"
  L13_1.E = "+"
  L13_1.W = "+"
  L13_1.V = "|"
  L13_1.H = "-"
  L13_1.X = "+"
  L14_1 = {}
  L15_1 = L12_1.noReset
  L16_1 = "%{cyan}"
  L15_1 = L15_1(L16_1)
  L14_1[1] = L15_1
  L15_1 = L12_1.noReset
  L16_1 = "%{white}"
  L15_1 = L15_1(L16_1)
  L14_1[2] = L15_1
  function L15_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L2_2 = A0_2
    L1_2 = A0_2.gsub
    L3_2 = "\027[^m]*m"
    L4_2 = ""
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    A0_2 = L1_2
    L1_2 = #A0_2
    return L1_2
  end
  L16_1 = string
  L16_1 = L16_1.sub
  L17_1 = os
  L17_1 = L17_1.getenv
  L18_1 = "LANG"
  L17_1 = L17_1(L18_1)
  if not L17_1 then
    L17_1 = ""
  end
  L18_1 = L17_1
  L17_1 = L17_1.upper
  L17_1 = L17_1(L18_1)
  L18_1 = L17_1
  L17_1 = L17_1.match
  L19_1 = "UTF%-?8"
  L17_1 = L17_1(L18_1, L19_1)
  if L17_1 then
    L17_1 = {}
    L17_1.NW = "\226\148\140"
    L17_1.NE = "\226\148\144"
    L17_1.SW = "\226\148\148"
    L17_1.SE = "\226\148\152"
    L17_1.N = "\226\148\172"
    L17_1.S = "\226\148\180"
    L17_1.E = "\226\148\164"
    L17_1.W = "\226\148\156"
    L17_1.V = "\226\148\130"
    L17_1.H = "\226\148\128"
    L17_1.X = "\226\148\188"
    L13_1 = L17_1
    function L17_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2
      L2_2 = A0_2
      L1_2 = A0_2.gsub
      L3_2 = "\027[^m]*m"
      L4_2 = ""
      L1_2 = L1_2(L2_2, L3_2, L4_2)
      A0_2 = L1_2
      L1_2 = L9_1.len
      L2_2 = A0_2
      L1_2 = L1_2(L2_2)
      if not L1_2 then
        L1_2 = #A0_2
      end
      return L1_2
    end
    L15_1 = L17_1
    function L17_1(A0_2, A1_2, A2_2)
      local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
      L3_2 = L9_1.offset
      L4_2 = A0_2
      L5_2 = A2_2 + 1
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L3_2 = L3_2 - 1
      end
      L5_2 = A0_2
      L4_2 = A0_2.sub
      L6_2 = L9_1.offset
      L7_2 = A0_2
      L8_2 = A1_2
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = L3_2
      return L4_2(L5_2, L6_2, L7_2)
    end
    L16_1 = L17_1
  end
  L17_1 = {}
  L18_1 = nil
  L19_1 = nil
  function L20_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = table
    L2_2 = L2_2.insert
    L3_2 = A0_2
    L4_2 = A1_2
    L2_2(L3_2, L4_2)
    L2_2 = math
    L2_2 = L2_2.max
    L3_2 = A0_2.width
    if not L3_2 then
      L3_2 = 0
    end
    L4_2 = L15_1
    L5_2 = A1_2
    L4_2, L5_2 = L4_2(L5_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    A0_2.width = L2_2
  end
  L21_1 = {}
  function L22_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = "\\"
    L2_2 = string
    L2_2 = L2_2.byte
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2 = L1_2 .. L2_2
    return L1_2
  end
  function L23_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    L4_2 = {}
    L5_2 = 0
    L6_2 = {}
    L7_2 = pairs
    L8_2 = A0_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      if A3_2 then
        L13_2 = type
        L14_2 = L11_2
        L13_2 = L13_2(L14_2)
        if "number" == L13_2 then
          goto lbl_37
        end
      end
      L13_2 = table
      L13_2 = L13_2.insert
      L14_2 = L4_2
      L15_2 = {}
      L15_2.v1 = L11_2
      L15_2.v2 = L12_2
      L13_2(L14_2, L15_2)
      L13_2 = tostring
      L14_2 = L11_2
      L13_2 = L13_2(L14_2)
      L6_2[L11_2] = L13_2
      L13_2 = math
      L13_2 = L13_2.max
      L14_2 = L5_2
      L15_2 = L15_1
      L16_2 = L6_2[L11_2]
      L15_2, L16_2, L17_2, L18_2 = L15_2(L16_2)
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
      L5_2 = L13_2
      ::lbl_37::
    end
    L7_2 = table
    L7_2 = L7_2.sort
    L8_2 = L4_2
    function L9_2(A0_3, A1_3)
      local L2_3, L3_3, L4_3
      L2_3 = type
      L3_3 = A0_3.v1
      L2_3 = L2_3(L3_3)
      if "number" == L2_3 then
        L2_3 = type
        L3_3 = A1_3.v1
        L2_3 = L2_3(L3_3)
        if "number" == L2_3 then
          L2_3 = A0_3.v1
          L3_3 = A1_3.v1
          L2_3 = L2_3 < L3_3
          return L2_3
      end
      else
        L2_3 = tostring
        L3_3 = A0_3.v1
        L2_3 = L2_3(L3_3)
        L3_3 = tostring
        L4_3 = A1_3.v1
        L3_3 = L3_3(L4_3)
        L2_3 = L2_3 < L3_3
        return L2_3
      end
    end
    L7_2(L8_2, L9_2)
    L7_2 = 1
    L8_2 = #L4_2
    L9_2 = 1
    for L10_2 = L7_2, L8_2, L9_2 do
      L11_2 = L4_2[L10_2]
      L11_2 = L11_2.v1
      L11_2 = L6_2[L11_2]
      L12_2 = L4_2[L10_2]
      L13_2 = L11_2
      L14_2 = " "
      L15_2 = "."
      L16_2 = L15_2
      L15_2 = L15_2.rep
      L17_2 = L15_1
      L18_2 = L11_2
      L17_2 = L17_2(L18_2)
      L17_2 = L5_2 - L17_2
      L15_2 = L15_2(L16_2, L17_2)
      L16_2 = ":"
      L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
      L12_2.v1 = L13_2
    end
    L7_2 = L19_1
    L8_2 = L4_2
    L9_2 = A1_2
    L10_2 = A2_2
    L11_2 = nil
    L12_2 = true
    return L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  function L24_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
    L3_2 = {}
    L4_2 = tostring
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = L9_1.len
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      L6_2 = L4_2
      L5_2 = L4_2.gsub
      L7_2 = [=[
[
	]]=]
      L8_2 = {}
      L8_2["\n"] = "\\n"
      L8_2["\t"] = "\\t"
      L5_2 = L5_2(L6_2, L7_2, L8_2)
      L4_2 = L5_2
    else
      L6_2 = L4_2
      L5_2 = L4_2.gsub
      L7_2 = "[\000-\031\127-\255]"
      L8_2 = L22_1
      L5_2 = L5_2(L6_2, L7_2, L8_2)
      L4_2 = L5_2
    end
    L5_2 = L15_1
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 > 80 then
      L5_2 = 1
      L6_2 = L15_1
      L7_2 = L4_2
      L6_2 = L6_2(L7_2)
      L7_2 = 80
      for L8_2 = L5_2, L6_2, L7_2 do
        L9_2 = L20_1
        L10_2 = L3_2
        L11_2 = L16_1
        L12_2 = L4_2
        L13_2 = L8_2
        L14_2 = L8_2 + 79
        L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2, L13_2, L14_2)
        L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
      end
    else
      L5_2 = L20_1
      L6_2 = L3_2
      L7_2 = L4_2
      L5_2(L6_2, L7_2)
    end
    return L3_2
  end
  L25_1 = {}
  function L26_1(A0_2, A1_2, A2_2, A3_2, A4_2)
    local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2
    L5_2 = {}
    L6_2 = {}
    L7_2 = nil
    L8_2 = nil
    if A3_2 then
      L7_2 = A3_2
      L9_2 = {}
      L8_2 = L9_2
      L9_2 = ipairs
      L10_2 = L7_2
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        L8_2[L14_2] = true
      end
    end
    L9_2 = ipairs
    L10_2 = A0_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      L15_2 = type
      L16_2 = L14_2
      L15_2 = L15_2(L16_2)
      if "table" == L15_2 then
        L15_2 = pairs
        L16_2 = L14_2
        L15_2, L16_2, L17_2, L18_2 = L15_2(L16_2)
        for L19_2, L20_2 in L15_2, L16_2, L17_2, L18_2 do
          L21_2 = tostring
          L22_2 = L19_2
          L21_2 = L21_2(L22_2)
          if L8_2 then
            L22_2 = L8_2[L21_2]
            if not L22_2 then
              goto lbl_85
            end
          end
          L22_2 = L5_2[L21_2]
          if not L22_2 then
            L22_2 = {}
            L5_2[L21_2] = L22_2
            L22_2 = L5_2[L21_2]
            L23_2 = L15_1
            L24_2 = L21_2
            L23_2 = L23_2(L24_2)
            L22_2.width = L23_2
          end
          L22_2 = L18_1
          L23_2 = L20_2
          L24_2 = A1_2 or L24_2
          if A1_2 then
            L24_2 = L14_1
            L24_2 = #L24_2
            L24_2 = L13_2 % L24_2
            L25_2 = L24_2 + 1
            L24_2 = L14_1
            L24_2 = L24_2[L25_2]
          end
          L25_2 = A2_2
          L22_2 = L22_2(L23_2, L24_2, L25_2)
          L23_2 = L5_2[L21_2]
          L23_2[L13_2] = L22_2
          L23_2 = L5_2[L21_2]
          L24_2 = math
          L24_2 = L24_2.max
          L25_2 = L5_2[L21_2]
          L25_2 = L25_2.width
          L26_2 = L22_2.width
          L24_2 = L24_2(L25_2, L26_2)
          L23_2.width = L24_2
          L23_2 = math
          L23_2 = L23_2.max
          L24_2 = L6_2[L13_2]
          if not L24_2 then
            L24_2 = 0
          end
          L25_2 = #L22_2
          L23_2 = L23_2(L24_2, L25_2)
          L6_2[L13_2] = L23_2
          ::lbl_85::
        end
      end
    end
    if not A3_2 then
      L9_2 = {}
      L7_2 = L9_2
      L9_2 = {}
      L8_2 = L9_2
      L9_2 = pairs
      L10_2 = L5_2
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        L15_2 = L8_2[L13_2]
        if not L15_2 then
          L15_2 = table
          L15_2 = L15_2.insert
          L16_2 = L7_2
          L17_2 = L13_2
          L15_2(L16_2, L17_2)
          L8_2[L13_2] = true
        end
      end
      L9_2 = table
      L9_2 = L9_2.sort
      L10_2 = L7_2
      L9_2(L10_2)
    end
    function L9_2(A0_3, A1_3, A2_3, A3_3)
      local L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
      L4_3 = L5_2
      L4_3 = L4_3[A1_3]
      L4_3 = L4_3.width
      if not A2_3 then
        A2_3 = ""
      end
      if A3_3 then
        L5_3 = table
        L5_3 = L5_3.insert
        L6_3 = A0_3
        L7_3 = A3_3
        L5_3(L6_3, L7_3)
      else
        L5_3 = A1_2
        if L5_3 then
          L5_3 = table
          L5_3 = L5_3.insert
          L6_3 = A0_3
          L7_3 = A1_2
          L5_3(L6_3, L7_3)
        end
      end
      L5_3 = table
      L5_3 = L5_3.insert
      L6_3 = A0_3
      L7_3 = A2_3
      L8_3 = " "
      L9_3 = L8_3
      L8_3 = L8_3.rep
      L10_3 = L15_1
      L11_3 = A2_3
      L10_3 = L10_3(L11_3)
      L10_3 = L4_3 - L10_3
      L8_3 = L8_3(L9_3, L10_3)
      L7_3 = L7_3 .. L8_3
      L5_3(L6_3, L7_3)
      if A3_3 then
        L5_3 = table
        L5_3 = L5_3.insert
        L6_3 = A0_3
        L7_3 = A1_2
        L5_3(L6_3, L7_3)
      end
      L5_3 = table
      L5_3 = L5_3.insert
      L6_3 = A0_3
      L7_3 = L13_1.V
      L5_3(L6_3, L7_3)
    end
    L10_2 = {}
    L11_2 = {}
    L12_2 = L13_1.NW
    L11_2[1] = L12_2
    L12_2 = {}
    L13_2 = L13_1.SW
    L12_2[1] = L13_2
    L13_2 = ipairs
    L14_2 = L7_2
    L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
    for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
      L19_2 = table
      L19_2 = L19_2.insert
      L20_2 = L11_2
      L21_2 = L13_1.H
      L22_2 = L21_2
      L21_2 = L21_2.rep
      L23_2 = L5_2[L18_2]
      L23_2 = L23_2.width
      L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L21_2(L22_2, L23_2)
      L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
      L19_2 = table
      L19_2 = L19_2.insert
      L20_2 = L12_2
      L21_2 = L13_1.H
      L22_2 = L21_2
      L21_2 = L21_2.rep
      L23_2 = L5_2[L18_2]
      L23_2 = L23_2.width
      L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L21_2(L22_2, L23_2)
      L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
      L19_2 = #L7_2
      if L17_2 < L19_2 then
        L19_2 = table
        L19_2 = L19_2.insert
        L20_2 = L11_2
        L21_2 = L13_1.N
        L19_2(L20_2, L21_2)
        L19_2 = table
        L19_2 = L19_2.insert
        L20_2 = L12_2
        L21_2 = L13_1.S
        L19_2(L20_2, L21_2)
      end
    end
    L13_2 = table
    L13_2 = L13_2.insert
    L14_2 = L11_2
    L15_2 = L13_1.NE
    L13_2(L14_2, L15_2)
    L13_2 = table
    L13_2 = L13_2.insert
    L14_2 = L12_2
    L15_2 = L13_1.SE
    L13_2(L14_2, L15_2)
    L13_2 = L20_1
    L14_2 = L10_2
    L15_2 = table
    L15_2 = L15_2.concat
    L16_2 = L11_2
    L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L15_2(L16_2)
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
    if not A4_2 then
      L13_2 = {}
      L14_2 = L13_1.V
      L13_2[1] = L14_2
      L14_2 = {}
      L15_2 = L13_1.V
      L14_2[1] = L15_2
      L15_2 = ipairs
      L16_2 = L7_2
      L15_2, L16_2, L17_2, L18_2 = L15_2(L16_2)
      for L19_2, L20_2 in L15_2, L16_2, L17_2, L18_2 do
        L21_2 = L9_2
        L22_2 = L13_2
        L23_2 = L20_2
        L24_2 = L20_2
        L21_2(L22_2, L23_2, L24_2)
        L21_2 = L9_2
        L22_2 = L14_2
        L23_2 = L20_2
        L24_2 = L13_1.H
        L25_2 = L24_2
        L24_2 = L24_2.rep
        L26_2 = L15_1
        L27_2 = L20_2
        L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L26_2(L27_2)
        L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
        L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
      end
      L15_2 = L20_1
      L16_2 = L10_2
      L17_2 = table
      L17_2 = L17_2.concat
      L18_2 = L13_2
      L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L17_2(L18_2)
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
      L15_2 = L20_1
      L16_2 = L10_2
      L17_2 = table
      L17_2 = L17_2.concat
      L18_2 = L14_2
      L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L17_2(L18_2)
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
    end
    L13_2 = 1
    L14_2 = #A0_2
    L15_2 = 1
    for L16_2 = L13_2, L14_2, L15_2 do
      L17_2 = 1
      L18_2 = L6_2[L16_2]
      if not L18_2 then
        L18_2 = 1
      end
      L19_2 = 1
      for L20_2 = L17_2, L18_2, L19_2 do
        L21_2 = {}
        L22_2 = L13_1.V
        L21_2[1] = L22_2
        L22_2 = ipairs
        L23_2 = L7_2
        L22_2, L23_2, L24_2, L25_2 = L22_2(L23_2)
        for L26_2, L27_2 in L22_2, L23_2, L24_2, L25_2 do
          L28_2 = L5_2[L27_2]
          L28_2 = L28_2[L16_2]
          L29_2 = L9_2
          L30_2 = L21_2
          L31_2 = L27_2
          if L28_2 then
            L32_2 = L28_2[L20_2]
            if L32_2 then
              goto lbl_261
            end
          end
          L32_2 = ""
          ::lbl_261::
          L33_2 = A1_2 or L33_2
          if A1_2 then
            L33_2 = L14_1
            L33_2 = #L33_2
            L33_2 = L16_2 % L33_2
            L34_2 = L33_2 + 1
            L33_2 = L14_1
            L33_2 = L33_2[L34_2]
          end
          L29_2(L30_2, L31_2, L32_2, L33_2)
        end
        L22_2 = L20_1
        L23_2 = L10_2
        L24_2 = table
        L24_2 = L24_2.concat
        L25_2 = L21_2
        L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L24_2(L25_2)
        L22_2(L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
      end
    end
    L13_2 = L20_1
    L14_2 = L10_2
    L15_2 = table
    L15_2 = L15_2.concat
    L16_2 = L12_2
    L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2 = L15_2(L16_2)
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
    L13_2 = A0_2
    L14_2 = pairs
    L15_2 = L13_2
    L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
    for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
      L20_2 = type
      L21_2 = L18_2
      L20_2 = L20_2(L21_2)
      if "number" ~= L20_2 then
        L20_2 = L23_1
        L21_2 = L13_2
        L22_2 = A1_2
        L23_2 = A2_2
        L24_2 = true
        L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2)
        L21_2 = ipairs
        L22_2 = L20_2
        L21_2, L22_2, L23_2, L24_2 = L21_2(L22_2)
        for L25_2, L26_2 in L21_2, L22_2, L23_2, L24_2 do
          L27_2 = L20_1
          L28_2 = L10_2
          L29_2 = L26_2
          L27_2(L28_2, L29_2)
        end
        break
      end
    end
    return L10_2
  end
  L19_1 = L26_1
  function L26_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L4_2 = type
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if "table" == L4_2 then
      L4_2 = A2_2[A0_2]
      if L4_2 then
        L4_2 = "<see above>"
        L5_2 = {}
        L5_2[1] = L4_2
        L6_2 = L15_1
        L7_2 = L4_2
        L6_2 = L6_2(L7_2)
        L5_2.width = L6_2
        return L5_2
      end
    end
    A2_2[A0_2] = true
    L4_2 = type
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if "table" == L4_2 then
      L4_2 = A0_2
      L5_2 = #L4_2
      if L5_2 > 0 then
        L5_2 = type
        L6_2 = L4_2[1]
        L5_2 = L5_2(L6_2)
        if "table" == L5_2 then
          L5_2 = L19_1
          L6_2 = L4_2
          L7_2 = A1_2
          L8_2 = A2_2
          L9_2 = A3_2
          return L5_2(L6_2, L7_2, L8_2, L9_2)
      end
      else
        L5_2 = L23_1
        L6_2 = L4_2
        L7_2 = A1_2
        L8_2 = A2_2
        return L5_2(L6_2, L7_2, L8_2)
      end
    else
      L4_2 = L24_1
      L5_2 = A0_2
      L6_2 = A1_2
      L7_2 = A2_2
      return L4_2(L5_2, L6_2, L7_2)
    end
  end
  L18_1 = L26_1
  function L26_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L3_2 = table
    L3_2 = L3_2.concat
    L4_2 = L18_1
    L5_2 = A0_2
    L6_2 = A2_2 or L6_2
    if A2_2 then
      L6_2 = L14_1
      if L6_2 then
        L6_2 = L12_1.noReset
        L7_2 = "%{reset}"
        L6_2 = L6_2(L7_2)
      end
    end
    L7_2 = {}
    L8_2 = A1_2
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = "\n"
    return L3_2(L4_2, L5_2)
  end
  L10_1.show = L26_1
  L26_1 = setmetatable
  L27_1 = L10_1
  L28_1 = {}
  function L29_1(A0_2, ...)
    local L1_2, L2_2
    L1_2 = L10_1.show
    L2_2 = ...
    return L1_2(L2_2)
  end
  L28_1.__call = L29_1
  L26_1 = L26_1(L27_1, L28_1)
  Tabular = L26_1
  L26_1 = setmetatable
  L27_1 = {}
  L27_1.noReset = L7_1
  L28_1 = {}
  function L29_1(A0_2, A1_2)
    local L2_2, L3_2
    L2_2 = L12_1
    L3_2 = A1_2
    return L2_2(L3_2)
  end
  L28_1.__call = L29_1
  L26_1 = L26_1(L27_1, L28_1)
  Color = L26_1
end
L1_1 = SERVER
if L1_1 then
  local _prepared = {}
  function L2_1(A0_2, A1_2)
    local L2_2
    L2_2 = _prepared
    L2_2[A0_2] = A1_2
  end
  prepare = L2_1
  function L2_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    if A0_2 then
      L2_2 = _prepared
      L2_2 = L2_2[A0_2]
      A0_2 = L2_2 or A0_2
      if not L2_2 then
      end
    end
    L2_2 = {}
    L3_2 = pairs
    L4_2 = type
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    L4_2 = A1_2 or L4_2
    if "table" ~= L4_2 or not A1_2 then
      L4_2 = {}
    end
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = type
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if "table" == L9_2 then
        L9_2 = json
        L9_2 = L9_2.encode
        L10_2 = L8_2
        L9_2 = L9_2(L10_2)
        if L9_2 then
          goto lbl_33
        end
      end
      L9_2 = L8_2
      ::lbl_33::
      L10_2 = "@"
      L11_2 = L7_2
      L10_2 = L10_2 .. L11_2
      L11_2 = L9_2
      L2_2[L10_2] = L9_2
      L2_2[L7_2] = L11_2
    end
    L3_2 = {}
    L4_2 = {}
    L5_2 = "oxmysql"
    function L6_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = promise
      L0_3 = L0_3.new
      L0_3 = L0_3()
      L1_3 = exports
      L1_3 = L1_3.oxmysql
      L2_3 = L1_3
      L1_3 = L1_3.execute
      L3_3 = A0_2
      L4_3 = L2_2
      function L5_3(A0_4)
        local L1_4, L2_4, L3_4
        L1_4 = L0_3
        L2_4 = L1_4
        L1_4 = L1_4.resolve
        L3_4 = A0_4
        L1_4(L2_4, L3_4)
      end
      L1_3(L2_3, L3_3, L4_3, L5_3)
      L1_3 = Citizen
      L1_3 = L1_3.Await
      L2_3 = L0_3
      return L1_3(L2_3)
    end
    L4_2[1] = L5_2
    L4_2[2] = L6_2
    L5_2 = {}
    L6_2 = "GHMattiMySQL"
    function L7_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = promise
      L0_3 = L0_3.new
      L0_3 = L0_3()
      L1_3 = exports
      L1_3 = L1_3.GHMattiMySQL
      L2_3 = L1_3
      L1_3 = L1_3.QueryResultAsync
      L3_3 = A0_2
      L4_3 = L2_2
      function L5_3(A0_4)
        local L1_4, L2_4, L3_4
        L1_4 = L0_3
        L2_4 = L1_4
        L1_4 = L1_4.resolve
        L3_4 = A0_4
        L1_4(L2_4, L3_4)
      end
      L1_3(L2_3, L3_3, L4_3, L5_3)
      L1_3 = Citizen
      L1_3 = L1_3.Await
      L2_3 = L0_3
      return L1_3(L2_3)
    end
    L5_2[1] = L6_2
    L5_2[2] = L7_2
    L6_2 = {}
    L7_2 = "ghmattimysql"
    function L8_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = promise
      L0_3 = L0_3.new
      L0_3 = L0_3()
      L1_3 = exports
      L1_3 = L1_3.ghmattimysql
      L2_3 = L1_3
      L1_3 = L1_3.execute
      L3_3 = A0_2
      L4_3 = L2_2
      function L5_3(A0_4)
        local L1_4, L2_4, L3_4
        L1_4 = L0_3
        L2_4 = L1_4
        L1_4 = L1_4.resolve
        L3_4 = A0_4
        L1_4(L2_4, L3_4)
      end
      L1_3(L2_3, L3_3, L4_3, L5_3)
      L1_3 = Citizen
      L1_3 = L1_3.Await
      L2_3 = L0_3
      return L1_3(L2_3)
    end
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L7_2 = {}
    L8_2 = "mysql-async"
    function L9_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = promise
      L0_3 = L0_3.new
      L0_3 = L0_3()
      L1_3 = exports
      L1_3 = L1_3["mysql-async"]
      L2_3 = L1_3
      L1_3 = L1_3.mysql_fetch_all
      L3_3 = A0_2
      L4_3 = L2_2
      function L5_3(A0_4)
        local L1_4, L2_4, L3_4
        L1_4 = L0_3
        L2_4 = L1_4
        L1_4 = L1_4.resolve
        L3_4 = A0_4
        L1_4(L2_4, L3_4)
      end
      L1_3(L2_3, L3_3, L4_3, L5_3)
      L1_3 = Citizen
      L1_3 = L1_3.Await
      L2_3 = L0_3
      return L1_3(L2_3)
    end
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L3_2[1] = L4_2
    L3_2[2] = L5_2
    L3_2[3] = L6_2
    L3_2[4] = L7_2
    L4_2 = ipairs
    L5_2 = L3_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = GetResourceState
      L11_2 = L9_2[1]
      L10_2 = L10_2(L11_2)
      if "started" == L10_2 and A0_2 then
        L10_2 = L9_2[2]
        return L10_2()
      end
    end
    L4_2 = {}
    return L4_2
  end
  query = L2_1
end
L1_1 = table
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = 0
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = tonumber
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    if L8_2 and L1_2 < L8_2 then
      L1_2 = L8_2
    end
  end
  return L1_2
end
L1_1.maxn = L2_1
L1_1 = table
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "table" == L2_2 then
    L2_2 = type
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    if "table" == L2_2 then
      goto lbl_13
    end
  end
  L2_2 = false
  do return L2_2 end
  ::lbl_13::
  L2_2 = table
  L2_2 = L2_2.length
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = table
  L3_2 = L3_2.length
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if L2_2 ~= L3_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "table" == L8_2 then
      L8_2 = table
      L8_2 = L8_2.hasSameValues
      L9_2 = L7_2
      L10_2 = A1_2[L6_2]
      L8_2 = L8_2(L9_2, L10_2)
      if not L8_2 then
        L8_2 = false
        return L8_2
      end
    else
      L8_2 = A1_2[L6_2]
      if L8_2 ~= L7_2 then
        L8_2 = false
        return L8_2
      end
    end
  end
  L2_2 = true
  return L2_2
end
L1_1.hasSameValues = L2_1
L1_1 = table
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = 0
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2 in L2_2, L3_2, L4_2, L5_2 do
    L1_2 = L1_2 + 1
  end
  return L1_2
end
L1_1.length = L2_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = Citizen
  L1_2 = L1_2.Await
  L2_2 = A0_2.p
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = A0_2.r
  end
  L2_2 = table
  L2_2 = L2_2.unpack
  L3_2 = L1_2
  L4_2 = 1
  L5_2 = table
  L5_2 = L5_2.maxn
  L6_2 = L1_2
  L5_2, L6_2 = L5_2(L6_2)
  return L2_2(L3_2, L4_2, L5_2, L6_2)
end
function L2_1(A0_2, ...)
  local L1_2, L2_2, L3_2
  L1_2 = {}
  L2_2, L3_2 = ...
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  A0_2.r = L1_2
  L1_2 = A0_2.p
  L2_2 = L1_2
  L1_2 = L1_2.resolve
  L3_2 = A0_2.r
  L1_2(L2_2, L3_2)
end
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if A0_2 then
    L1_2 = Citizen
    L1_2 = L1_2.CreateThreadNow
    L2_2 = A0_2
    L1_2(L2_2)
  else
    L1_2 = setmetatable
    L2_2 = {}
    L3_2 = L1_1
    L2_2.wait = L3_2
    L3_2 = promise
    L3_2 = L3_2.new
    L3_2 = L3_2()
    L2_2.p = L3_2
    L3_2 = {}
    L4_2 = L2_1
    L3_2.__call = L4_2
    return L1_2(L2_2, L3_2)
  end
end
async = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = A0_2 or L3_2
  if not A0_2 then
    L3_2 = {}
  end
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "table" == L8_2 then
      L8_2 = copyTable
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      L1_2[L6_2] = L8_2
    else
      L1_2[L6_2] = L7_2
    end
  end
  return L1_2
end
copyTable = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = string
  L1_2 = L1_2.match
  L2_2 = A0_2
  L3_2 = "^([^%d]*%d)(%d*)(.-)$"
  L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2)
  L4_2 = L1_2
  L6_2 = L2_2
  L5_2 = L2_2.reverse
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2
  L5_2 = L5_2.gsub
  L7_2 = "(%d%d%d)"
  L8_2 = "%1."
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = L5_2
  L5_2 = L5_2.reverse
  L5_2 = L5_2(L6_2)
  L6_2 = L3_2
  L4_2 = L4_2 .. L5_2 .. L6_2
  return L4_2
end
format = L3_1
L3_1 = {}
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = ""
  L4_2 = L3_1
  L4_2 = L4_2[A1_2]
  if nil == L4_2 then
    L5_2 = {}
    L4_2 = L5_2
    L6_2 = A1_2
    L5_2 = A1_2.len
    L5_2 = L5_2(L6_2)
    L6_2 = 1
    L7_2 = L5_2
    L8_2 = 1
    for L9_2 = L6_2, L7_2, L8_2 do
      L10_2 = string
      L10_2 = L10_2.sub
      L11_2 = A1_2
      L12_2 = L9_2
      L13_2 = L9_2
      L10_2 = L10_2(L11_2, L12_2, L13_2)
      L4_2[L10_2] = true
    end
    L6_2 = L3_1
    L6_2[A1_2] = L4_2
  end
  L5_2 = 1
  L6_2 = string
  L6_2 = L6_2.len
  L7_2 = A0_2 or L7_2
  if not A0_2 then
    L7_2 = ""
  end
  L6_2 = L6_2(L7_2)
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = string
    L9_2 = L9_2.sub
    L10_2 = A0_2
    L11_2 = L8_2
    L12_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    if A2_2 then
      L10_2 = L4_2[L9_2]
      if L10_2 then
        goto lbl_50
      end
    end
    if not A2_2 then
      L10_2 = L4_2[L9_2]
      if not L10_2 then
        L10_2 = L3_2
        L11_2 = L9_2
        L10_2 = L10_2 .. L11_2
        L3_2 = L10_2
      end
    end
    ::lbl_50::
  end
  return L3_2
end
sanitizeString = L4_1
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "__cfx_export_%s_%s"
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
GetExportEventName = L4_1
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = false
  L3_2 = GetResourceState
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if "started" == L3_2 then
    L3_2 = TriggerEvent
    L4_2 = GetExportEventName
    L5_2 = A0_2
    L6_2 = A1_2
    L4_2 = L4_2(L5_2, L6_2)
    function L5_2(A0_3)
      local L1_3
      L2_2 = A0_3
    end
    L3_2(L4_2, L5_2)
    if not L2_2 then
      L3_2 = print
      L4_2 = "\027[31m ["
      L5_2 = L0_1
      L6_2 = "] Export %s not found in resource %s.\027[37m"
      L4_2 = L4_2 .. L5_2 .. L6_2
      L5_2 = L4_2
      L4_2 = L4_2.format
      L6_2 = A1_2
      L7_2 = A0_2
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)
      L3_2(L4_2, L5_2, L6_2, L7_2)
    end
  end
  return L2_2
end
DoesExportExist = L4_1
L4_1 = {}
L5_1 = {}
function L6_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = setmetatable
  L1_2 = {}
  L2_2 = {}
  L3_2 = L5_1
  L2_2.__index = L3_2
  L0_2 = L0_2(L1_2, L2_2)
  L2_2 = L0_2
  L1_2 = L0_2.construct
  L1_2(L2_2)
  return L0_2
end
L4_1.newIDGenerator = L6_1
function L6_1(A0_2)
  local L1_2, L2_2
  L2_2 = A0_2
  L1_2 = A0_2.clear
  L1_2(L2_2)
end
L5_1.construct = L6_1
function L6_1(A0_2)
  local L1_2
  A0_2.max = 0
  L1_2 = {}
  A0_2.ids = L1_2
end
L5_1.clear = L6_1
function L6_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.ids
  L1_2 = #L1_2
  if L1_2 > 0 then
    L1_2 = table
    L1_2 = L1_2.remove
    L2_2 = A0_2.ids
    return L1_2(L2_2)
  else
    L1_2 = A0_2.max
    L2_2 = A0_2.max
    L2_2 = L2_2 + 1
    A0_2.max = L2_2
    return L1_2
  end
end
L5_1.gen = L6_1
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = table
  L2_2 = L2_2.insert
  L3_2 = A0_2.ids
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L5_1.free = L6_1
L6_1 = nil
L7_1 = nil
L8_1 = SERVER
if L8_1 then
  L6_1 = TriggerClientEvent
  L7_1 = RegisterServerEvent
else
  L6_1 = TriggerServerEvent
  L7_1 = RegisterNetEvent
end
L8_1 = {}
Tunnel = L8_1
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if type(A0_2) ~= "table" then
    return
  end
  A1_2 = A1_2 or ""
  L2_2 = getmetatable
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.name
  L4_2 = L2_2.tunnel_ids
  L5_2 = L2_2.tunnel_callbacks
  L6_2 = L2_2.identifier
  L7_2 = A1_2
  L8_2 = false
  L9_2 = string
  L9_2 = L9_2.sub
  L10_2 = A1_2
  L11_2 = 1
  L12_2 = 1
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  if "_" == L9_2 then
    L9_2 = string
    L9_2 = L9_2.sub
    L10_2 = A1_2
    L11_2 = 2
    L9_2 = L9_2(L10_2, L11_2)
    L7_2 = L9_2
    L8_2 = true
  end
  function L9_2(...)
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = nil
    L1_3 = {}
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = ...
    L1_3[1] = L2_3
    L1_3[2] = L3_3
    L1_3[3] = L4_3
    L1_3[4] = L5_3
    L1_3[5] = L6_3
    L1_3[6] = L7_3
    L1_3[7] = L8_3
    L1_3[8] = L9_3
    L1_3[9] = L10_3
    L2_3 = nil
    L3_3 = SERVER
    if L3_3 then
      L2_3 = L1_3[1]
      L3_3 = {}
      L4_3 = table
      L4_3 = L4_3.unpack
      L5_3 = L1_3
      L6_3 = 2
      L7_3 = table
      L7_3 = L7_3.maxn
      L8_3 = L1_3
      L7_3, L8_3, L9_3, L10_3 = L7_3(L8_3)
      L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L3_3[1] = L4_3
      L3_3[2] = L5_3
      L3_3[3] = L6_3
      L3_3[4] = L7_3
      L3_3[5] = L8_3
      L3_3[6] = L9_3
      L3_3[7] = L10_3
      L1_3 = L3_3
      if L2_3 and L2_3 >= 0 then
        L3_3 = L8_2
        if not L3_3 then
          L3_3 = async
          L3_3 = L3_3()
          L0_3 = L3_3
        end
      end
    else
      L3_3 = L8_2
      if not L3_3 then
        L3_3 = async
        L3_3 = L3_3()
        L0_3 = L3_3
      end
    end
    L3_3 = -1
    if L0_3 then
      L4_3 = L4_2
      L5_3 = L4_3
      L4_3 = L4_3.gen
      L4_3 = L4_3(L5_3)
      L3_3 = L4_3
      L4_3 = L5_2
      L4_3[L3_3] = L0_3
    end
    L4_3 = SERVER
    if L4_3 and L2_3 then
      L4_3 = L6_1
      L5_3 = L3_2
      L6_3 = "-tunnel_req"
      L5_3 = L5_3 .. L6_3
      L6_3 = L2_3
      L7_3 = L7_2
      L8_3 = L1_3
      L9_3 = L6_2
      L10_3 = L3_3
      L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    else
      L4_3 = CLIENT
      if L4_3 then
        L4_3 = L6_1
        L5_3 = L3_2
        L6_3 = "-tunnel_req"
        L5_3 = L5_3 .. L6_3
        L6_3 = L7_2
        L7_3 = L1_3
        L8_3 = L6_2
        L9_3 = L3_3
        L4_3(L5_3, L6_3, L7_3, L8_3, L9_3)
      end
    end
    if L0_3 then
      L5_3 = L0_3
      L4_3 = L0_3.wait
      return L4_3(L5_3)
    end
  end
  A0_2[A1_2] = L9_2
  return L9_2
end
L9_1 = Tunnel
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L7_1
  L2_2 = L0_1
  L3_2 = "-tunnel_req"
  L2_2 = L2_2 .. L3_2
  L1_2(L2_2)
  L1_2 = AddEventHandler
  L2_2 = L0_1
  L3_2 = "-tunnel_req"
  L2_2 = L2_2 .. L3_2
  function L3_2(A0_3, A1_3, A2_3, A3_3)
    local L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L4_3 = source
    L5_3 = A0_2
    L5_3 = L5_3[A0_3]
    L6_3 = {}
    L7_3 = type
    L8_3 = L5_3
    L7_3 = L7_3(L8_3)
    if "function" == L7_3 then
      L7_3 = {}
      L8_3 = L5_3
      L9_3 = table
      L9_3 = L9_3.unpack
      L10_3 = A1_3
      L11_3 = 1
      L12_3 = table
      L12_3 = L12_3.maxn
      L13_3 = A1_3
      L12_3, L13_3 = L12_3(L13_3)
      L9_3, L10_3, L11_3, L12_3, L13_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
      L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L8_3(L9_3, L10_3, L11_3, L12_3, L13_3)
      L7_3[1] = L8_3
      L7_3[2] = L9_3
      L7_3[3] = L10_3
      L7_3[4] = L11_3
      L7_3[5] = L12_3
      L7_3[6] = L13_3
      L6_3 = L7_3
    end
    if A3_3 >= 0 then
      L7_3 = SERVER
      if L7_3 then
        L7_3 = L6_1
        L8_3 = L0_1
        L9_3 = "-tunnel_res"
        L8_3 = L8_3 .. L9_3
        L9_3 = L4_3
        L10_3 = A3_3
        L11_3 = L6_3
        L7_3(L8_3, L9_3, L10_3, L11_3)
      else
        L7_3 = L6_1
        L8_3 = L0_1
        L9_3 = "-tunnel_res"
        L8_3 = L8_3 .. L9_3
        L9_3 = A3_3
        L10_3 = L6_3
        L7_3(L8_3, L9_3, L10_3)
      end
    end
  end
  L1_2(L2_2, L3_2)
end
L9_1.bindInterface = L10_1
L9_1 = Tunnel
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = {}
  L1_2 = L4_1.newIDGenerator
  L1_2 = L1_2()
  L2_2 = setmetatable
  L3_2 = {}
  L4_2 = {}
  L5_2 = L8_1
  L4_2.__index = L5_2
  L5_2 = L0_1
  L4_2.name = L5_2
  L4_2.tunnel_ids = L1_2
  L4_2.tunnel_callbacks = L0_2
  L5_2 = L0_1
  L4_2.identifier = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L7_1
  L4_2 = L0_1
  L5_2 = "-tunnel_res"
  L4_2 = L4_2 .. L5_2
  L3_2(L4_2)
  L3_2 = AddEventHandler
  L4_2 = L0_1
  L5_2 = "-tunnel_res"
  L4_2 = L4_2 .. L5_2
  function L5_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L2_3 = L0_2
    L2_3 = L2_3[A0_3]
    if L2_3 then
      L3_3 = L1_2
      L4_3 = L3_3
      L3_3 = L3_3.free
      L5_3 = A0_3
      L3_3(L4_3, L5_3)
      L3_3 = L0_2
      L3_3[A0_3] = nil
      L3_3 = L2_3
      L4_3 = table
      L4_3 = L4_3.unpack
      L5_3 = A1_3
      L6_3 = 1
      L7_3 = table
      L7_3 = L7_3.maxn
      L8_3 = A1_3
      L7_3, L8_3 = L7_3(L8_3)
      L4_3, L5_3, L6_3, L7_3, L8_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
      L3_3(L4_3, L5_3, L6_3, L7_3, L8_3)
    end
  end
  L3_2(L4_2, L5_2)
  return L2_2
end
L9_1.getInterface = L10_1
