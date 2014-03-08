{-# LANGUAGE RankNTypes, DeriveDataTypeable #-}

module WebIdl.Ast where

import WebIdl.Literal

import Data.Typeable
import Data.Data

data Ident = Ident String  deriving (Show, Eq, Typeable, Data)

data ExtendedAttributes = 
    NoInterfaceObject
    | OtherEA String
      deriving (Show, Eq, Read, Typeable, Data)

-- | Extended Attribute
data ExtendedAtt = 
    ExtendedAtt [ExtendedAttributes]
      deriving (Show, Eq, Typeable, Data)

data Nullable = Nullable Bool  deriving (Show, Eq, Typeable, Data)
data Array    = Array Bool     deriving (Show, Eq, Typeable, Data)
data Sequence = Sequence Bool  deriving (Show, Eq, Typeable, Data)
data Type     = Type Ident Nullable Array Sequence deriving (Show, Eq, Typeable, Data)

type Default   = Maybe Literal
data Optional  = Optional Bool deriving (Show, Eq, Typeable, Data)
data FormalArg = 
    -- TODO Notice that variadic arguments are only allowed to be in the end of the argument list
    -- so better create an ArgumentList [RegularArg] (Maybe VariadicArg)
      VariadicArg Ident Type ExtendedAtt
    | RegularArg Ident Type Optional Default ExtendedAtt deriving (Show, Eq, Typeable, Data)

data CallbackDef = CallbackDef Type [FormalArg] deriving (Show, Eq, Typeable, Data)
     
type InheritsFrom = Maybe Type

data ReadOnly = ReadOnly Bool deriving (Show, Eq, Typeable, Data)
data Inherit  = Inherit Bool  deriving (Show, Eq, Typeable, Data)
data IMember  =
    Const Ident Type Literal ExtendedAtt 
    | Attribute Ident Type ReadOnly Inherit ExtendedAtt 
    | Operation Ident Type [FormalArg] ExtendedAtt -- TODO static - http://www.w3.org/TR/WebIDL/#idl-static-operations
    -- these are know as "specials" in the spec
    | Getter (Maybe Ident) Type FormalArg           -- getters and setters and other
    | Setter (Maybe Ident) Type FormalArg FormalArg -- specials http://www.w3.org/TR/WebIDL/#idl-indexed-properties. 
    | Deleter (Maybe Ident) Type FormalArg          -- this is crazy...
    | Creator (Maybe Ident) Type FormalArg FormalArg  
        deriving (Show, Eq, Typeable, Data)

data DictAttribute = DictAttribute Ident Type Default ExtendedAtt deriving (Show, Eq, Typeable, Data)

data Partial = Partial Bool deriving (Show, Eq, Typeable, Data)

data Definition =  
    -- TODO: consider if partial interface should have its own type
    Interface Ident InheritsFrom Partial [IMember] ExtendedAtt
    | Callback Ident CallbackDef ExtendedAtt
    | Dictionary Ident InheritsFrom [DictAttribute] ExtendedAtt  
    | TypeDef Ident Type ExtendedAtt 
    | Implements Ident Ident ExtendedAtt 
    | Enum Ident [String] ExtendedAtt 
      deriving (Show, Eq, Typeable, Data)

data Definitions = Definitions [Definition]

data WebIdl = WebIdl [Definition] deriving (Show, Eq, Typeable, Data)

