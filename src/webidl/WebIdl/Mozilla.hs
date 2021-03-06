module WebIdl.Mozilla where

import WebIdl.Helper
import WebIdl.Query
import WebIdl.Process

import Control.Applicative((<$>))
import Data.List(isPrefixOf)

mozIdlNames :: [String]
mozIdlNames = [
    "Window", "Navigator", "Element", "History_", 

    "Document","DocumentType","DocumentFragment","FormData",

    "HTMLAnchorElement",          "HTMLMediaElement",
    "HTMLAppletElement",          "HTMLMenuElement",
    "HTMLAreaElement",            "HTMLMenuItemElement",
    "HTMLAudioElement",           "HTMLMetaElement",
    "HTMLBRElement",              "HTMLMeterElement",
    "HTMLBaseElement",            "HTMLModElement",
    "HTMLBodyElement",            "HTMLOListElement",
    "HTMLButtonElement",          "HTMLObjectElement",
    "HTMLCanvasElement",          "HTMLOptGroupElement",
    "HTMLCollection",             "HTMLOptionElement",
    "HTMLDListElement",           "HTMLOptionsCollection",
    "HTMLDataElement",            "HTMLOutputElement",
    "HTMLDataListElement",        "HTMLParagraphElement",
    "HTMLDirectoryElement",       "HTMLParamElement",
    "HTMLDivElement",             "HTMLPreElement",
    "HTMLDocument",               "HTMLProgressElement",
    "HTMLElement",                "HTMLPropertiesCollection",
    "HTMLEmbedElement",           "HTMLQuoteElement",
    "HTMLFieldSetElement",        "HTMLScriptElement",
    "HTMLFontElement",            "HTMLSelectElement",
    "HTMLFormControlsCollection", "HTMLSourceElement",
    "HTMLFormElement",            "HTMLSpanElement",
    "HTMLFrameElement",           "HTMLStyleElement",
    "HTMLFrameSetElement",        "HTMLTableCaptionElement",
    "HTMLHRElement",              "HTMLTableCellElement",
    "HTMLHeadElement",            "HTMLTableColElement",
    "HTMLHeadingElement",         "HTMLTableElement",
    "HTMLHtmlElement",            "HTMLTableRowElement",
    "HTMLIFrameElement",          "HTMLTableSectionElement",
    "HTMLImageElement",           "HTMLTemplateElement",
    "HTMLInputElement",           "HTMLTextAreaElement",
    "HTMLLIElement",              "HTMLTimeElement",
    "HTMLLabelElement",           "HTMLTitleElement",
    "HTMLLegendElement",          "HTMLTrackElement",
    "HTMLLinkElement",            "HTMLUListElement",
    "HTMLMapElement",             "HTMLVideoElement",

    "MutationObserver",

    "MimeType", "MimeTypeArray",

    "CDATASection", "CharacterData", "Comment", "ProcessingInstruction",

    "Text", "CaretPosition",

    "Node", "NodeIterator", "NodeFilter", "NodeList", "Attr",
    "DOMTokenList", "DOMImplementation", "DOMRectList", "DOMRect",
    "DOMSettableTokenList", "DOMError","DOMException", "DOMStringMap", 
    "DOMStringList", "DOMRequest",
    "ChildNode","ParentNode", "Range", "TreeWalker",

    "XPathEvaluator", 

    "URLUtils",

    -- https://dvcs.w3.org/hg/IndexedDB/raw-file/tip/Overview.html
    "IDBCursor","IDBFileHandle","IDBOpenDBRequest",
    "IDBDatabase","IDBIndex","IDBRequest",
    "IDBEnvironment","IDBKeyRange","IDBTransaction",
    "IDBFactory","IDBObjectStore","IDBVersionChangeEvent", -- "FileHandle",
    "StorageType",

    "ValidityState",

    -- http://www.w3.org/TR/DOM-Parsing/
    "DOMParser",

    -- http://www.w3.org/TR/2014/WD-XMLHttpRequest-20140130/
    "XMLHttpRequest", "XMLHttpRequestEventTarget", "XMLHttpRequestUpload",
    
    -- http://www.w3.org/TR/geolocation-API/
    "Geolocation", "Location", "PositionError", "Coordinates",
    "Position",

    "Function", 
    
    "Event", "EventListener", "EventHandler", "EventTarget", "EventSource", 

    "Screen", 
    "StorageEvent",
    "Performance", "PerformanceTiming", "PerformanceNavigation", 

    -- http://www.w3.org/TR/websockets/
    "WebSocket",
    
    -- http://dev.w3.org/csswg/css3-conditional/
    "CSS",

    -- http://dev.w3.org/csswg/cssom/
    "StyleSheet", "CSSStyleDeclaration", "CSSValue",
    "CSSStyleSheet", "CSSValueList", "LinkStyle","Rect",

    -- DOM Level 2 according to google, didn't look much for it
    -- http://www.w3.org/TR/2000/REC-DOM-Level-2-Style-20001113/idl-definitions.html
    "CSSPrimitiveValue", "RGBColor"

    ]

mozIdls :: [String]
mozIdls = otherIdls ++ ((mozHome ++) <$> (++".webidl") <$> mozIdlNames)

mozHome :: String
mozHome = "/Users/pedrofurla/dev/projects/tmp/browsers/mozilla-release/dom/webidl/"

mozLooseTypes :: IO ()
mozLooseTypes = queryDef mozIdls $ show . (filter (not . isPrefixOf "Moz")) .  looseTypes . process
