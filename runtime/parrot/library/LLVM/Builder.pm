class LLVM::Builder is LLVM::Opaque {

    multi method create () {
        self.new.wrap( LLVM::call("CreateBuilder", ) );
    }

    multi method create ($context) {
        self.new.wrap( LLVM::call("CreateBuilderInContext", $context) );
    }

    method DESTROY () {
        LLVM::call("DisposeBuilder", self);
    }

#            LLVMPositionBuilder             => "vppp",
    multi method set_position(LLVM::BasicBlock $bb, $value) {
        LLVM::call("PositionBuilder", self, $bb, $value);
    }

#            LLVMPositionBuilderBefore       => "vpp",
    multi method set_position($value) {
        LLVM::call("PositionBuilderBefore", self, $value);
    }

#            LLVMPositionBuilderAtEnd        => "vpp",
    multi method set_position(LLVM::BasicBlock $bb) {
        LLVM::call("PositionBuilderAtEnd", self, $bb);
    }

#            LLVMGetInsertBlock              => "pp",
#            LLVMClearInsertionPosition      => "vp",
#            LLVMInsertIntoBuilder           => "vpp",
#            LLVMInsertIntoBuilderWithName   => "vppt",
#            LLVMDisposeBuilder              => "vp",

#            # Terminators
#            LLVMBuildRetVoid                => "pp",
    multi method ret() {
        LLVM::call("BuildRetVoid", self);
    }

#            LLVMBuildRet                    => "ppp",
    multi method ret($value) {
        LLVM::call("BuildRet", self, $value);
    }
#            LLVMBuildAggregateRet           => "ppp3",
#            LLVMBuildBr                     => "ppp",
#            LLVMBuildCondBr                 => "ppppp",
#            LLVMBuildSwitch                 => "ppppi",
#            LLVMBuildInvoke                 => "ppppippt",
#            LLVMBuildUnwind                 => "pp",
#            LLVMBuildUnreachable            => "pp",

#            # Add a case to the switch instruction */
#            LLVMAddCase => "vppp",

#            # Arithmetic
#            LLVMBuildAdd        => "ppppt",
#            LLVMBuildNSWAdd     => "ppppt",
#            LLVMBuildFAdd       => "ppppt",
#            LLVMBuildSub        => "ppppt",
#            LLVMBuildFSub       => "ppppt",
#            LLVMBuildMul        => "ppppt",
#            LLVMBuildFMul       => "ppppt",
#            LLVMBuildUDiv       => "ppppt",
#            LLVMBuildSDiv       => "ppppt",
#            LLVMBuildExactSDiv  => "ppppt",
#            LLVMBuildFDiv       => "ppppt",
#            LLVMBuildURem       => "ppppt",
#            LLVMBuildSRem       => "ppppt",
#            LLVMBuildFRem       => "ppppt",
#            LLVMBuildShl        => "ppppt",
#            LLVMBuildLShr       => "ppppt",
#            LLVMBuildAShr       => "ppppt",
#            LLVMBuildAnd        => "ppppt",
#            LLVMBuildOr         => "ppppt",
#            LLVMBuildXor        => "ppppt",

#            LLVMBuildNeg => "pppt",
#            LLVMBuildNot => "pppt",

#            # Memory
#            LLVMBuildMalloc             => "pppt",
#            LLVMBuildArrayMalloc        => "ppppt",
#            LLVMBuildAlloca             => "pppt",
    method alloca($type, $name?) {
        LLVM::call("BuildAlloca", self, $type, $name);
    }
#            LLVMBuildArrayAlloca        => "ppppt",
#            LLVMBuildFree               => "ppp",
#            LLVMBuildLoad               => "pppt",
    method load($ptr, $name?) {
        LLVM::call("BuildLoad", self, $ptr, $name);
    }
#            LLVMBuildStore              => "pppp",
    method store($value, $ptr) {
        LLVM::call("BuildStore", self, $value, $ptr);
    }

#            LLVMBuildGEP                => "ppppit",
    method gep($type, *@indices, :$name?) {
        my $args := LLVM::to_array(@indices);
        my $r := LLVM::call("BuildGEP", self, $type, $args, +@indices, $name // "");
        $r;
    }

#            LLVMBuildStructGEP          => "ppp3t",
#            LLVMBuildInBoundsGEP        => "ppppit",
    method inbounds_gep($type, *@indices, :$name?) {
        my $args := LLVM::to_array(@indices);
        my $r := LLVM::call("BuildInBoundsGEP", self, $type, $args, +@indices, $name // "");
        $r;
    }

#            LLVMBuildStructGEP          => "ppp3t",
    method struct_gep($ptr, Int $idx, Str $name?) {
        LLVM::call("BuildStructGEP", self, $ptr, $idx, $name);
    }

#            LLVMBuildGlobalString       => "pptt",
    method global_string($value, $name) {
        LLVM::call("BuildGlobalString", self, $value, $name);
    }
#            LLVMBuildGlobalStringPtr    => "pptt",
    method global_string_ptr($value, $name) {
        LLVM::call("BuildGlobalStringPtr", self, $value, $name);
    }

#            # Casts
#            LLVMBuildTrunc => "ppppt",
#            LLVMBuildZExt => "ppppt",
#            LLVMBuildSExt => "ppppt",
#            LLVMBuildFPToUI => "ppppt",
#            LLVMBuildFPToSI => "ppppt",
#            LLVMBuildUIToFP => "ppppt",
#            LLVMBuildSIToFP => "ppppt",
#            LLVMBuildFPTrunc => "ppppt",
#            LLVMBuildFPExt => "ppppt",
#            LLVMBuildPtrToInt => "ppppt",
#            LLVMBuildIntToPtr => "ppppt",
#            LLVMBuildBitCast => "ppppt",
#            LLVMBuildZExtOrBitCast => "ppppt",
#            LLVMBuildSExtOrBitCast => "ppppt",
#            LLVMBuildTruncOrBitCast => "ppppt",
#            LLVMBuildPointerCast => "ppppt",
#            LLVMBuildIntCast => "ppppt",
#            LLVMBuildFPCast => "ppppt",

#            # Comparisons
#            LLVMBuildICmp => "pp3ppt",
#            LLVMBuildFCmp => "pp3ppt",

#            # Miscellaneous instructions
#            LLVMBuildPhi => "pppt",
#            LLVMBuildCall => "pppp3t", #FIXME

    method call($func, *@args, :$name?) {
        LLVM::call("BuildCall", 
            self,
            $func,
            LLVM::to_array(@args),
            +@args,
            $name // ""
        );
    }
#            LLVMBuildSelect => "pppppt",
#            LLVMBuildVAArg => "ppppt",
#            LLVMBuildExtractElement => "ppppt",
#            LLVMBuildInsertElement => "pppppt",
#            LLVMBuildShuffleVector => "pppppt",
#            LLVMBuildExtractValue => "ppp3t",
#            LLVMBuildInsertValue => "pppp3t",

#            LLVMBuildIsNull => "pppt",
#            LLVMBuildIsNotNull => "pppt",
#            LLVMBuildPtrDiff => "ppppt",

};

# vim: ft=perl6