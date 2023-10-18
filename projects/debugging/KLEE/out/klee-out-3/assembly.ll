; ModuleID = 'fuzzme.bc'
source_filename = "fuzzme.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"%d,%d,%s\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"some random text\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"b\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"c\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @fuzzMe(i32 %a, i32 %b, i8* %c) #0 !dbg !12 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c.addr = alloca i8*, align 8
  %s = alloca i8*, align 8
  %s11 = alloca i8*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store i8* %c, i8** %c.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %c.addr, metadata !20, metadata !DIExpression()), !dbg !21
  %0 = load i32, i32* %a.addr, align 4, !dbg !22
  %1 = load i32, i32* %b.addr, align 4, !dbg !23
  %2 = load i8*, i8** %c.addr, align 8, !dbg !24
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 %0, i32 %1, i8* %2), !dbg !25
  %3 = load i32, i32* %a.addr, align 4, !dbg !26
  %cmp = icmp sge i32 %3, 20000, !dbg !28
  %4 = load i32, i32* %b.addr, align 4
  %cmp1 = icmp sge i32 %4, 10000000
  %or.cond = select i1 %cmp, i1 %cmp1, i1 false, !dbg !29
  br i1 %or.cond, label %if.then2, label %if.end17, !dbg !29

if.then2:                                         ; preds = %entry
  %5 = load i32, i32* %b.addr, align 4, !dbg !30
  %6 = load i32, i32* %a.addr, align 4, !dbg !35
  %sub = sub nsw i32 %5, %6, !dbg !36
  %cmp3 = icmp slt i32 %sub, 200, !dbg !37
  br i1 %cmp3, label %if.then4, label %if.else, !dbg !38

if.then4:                                         ; preds = %if.then2
  %7 = load i8*, i8** %c.addr, align 8, !dbg !39
  call void @free(i8* %7) #5, !dbg !41
  call void @llvm.dbg.declare(metadata i8** %s, metadata !42, metadata !DIExpression()), !dbg !43
  %call5 = call noalias align 16 i8* @malloc(i64 17) #5, !dbg !44
  store i8* %call5, i8** %s, align 8, !dbg !43
  %8 = load i8*, i8** %s, align 8, !dbg !45
  %call6 = call i8* @strcpy(i8* %8, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i64 0, i64 0)) #5, !dbg !46
  %9 = load i8*, i8** %s, align 8, !dbg !47
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), i8* %9), !dbg !48
  br label %if.end17, !dbg !49

if.else:                                          ; preds = %if.then2
  %10 = load i8*, i8** %c.addr, align 8, !dbg !50
  %call8 = call i64 @strlen(i8* %10) #6, !dbg !53
  %cmp9 = icmp ult i64 %call8, 7, !dbg !54
  br i1 %cmp9, label %if.then10, label %if.end17, !dbg !55

if.then10:                                        ; preds = %if.else
  call void @llvm.dbg.declare(metadata i8** %s11, metadata !56, metadata !DIExpression()), !dbg !58
  %call12 = call noalias align 16 i8* @malloc(i64 1) #5, !dbg !59
  store i8* %call12, i8** %s11, align 8, !dbg !58
  %11 = load i8*, i8** %s11, align 8, !dbg !60
  %call13 = call i8* @strcpy(i8* %11, i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i64 0, i64 0)) #5, !dbg !61
  %12 = load i8*, i8** %s11, align 8, !dbg !62
  %call14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), i8* %12), !dbg !63
  br label %if.end17, !dbg !64

if.end17:                                         ; preds = %if.else, %if.then10, %if.then4, %entry
  ret void, !dbg !65
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: nounwind
declare dso_local noalias align 16 i8* @malloc(i64) #3

; Function Attrs: nounwind
declare dso_local i8* @strcpy(i8*, i8*) #3

; Function Attrs: nounwind readonly willreturn
declare dso_local i64 @strlen(i8*) #4

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !66 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca [100 x i8], align 16
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !69, metadata !DIExpression()), !dbg !70
  call void @llvm.dbg.declare(metadata i32* %b, metadata !71, metadata !DIExpression()), !dbg !72
  call void @llvm.dbg.declare(metadata [100 x i8]* %c, metadata !73, metadata !DIExpression()), !dbg !77
  %0 = bitcast i32* %a to i8*, !dbg !78
  call void @klee_make_symbolic(i8* %0, i64 4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0)), !dbg !79
  %1 = bitcast i32* %b to i8*, !dbg !80
  call void @klee_make_symbolic(i8* %1, i64 4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0)), !dbg !81
  %2 = bitcast [100 x i8]* %c to i8*, !dbg !82
  call void @klee_make_symbolic(i8* %2, i64 100, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0)), !dbg !83
  %arrayidx = getelementptr inbounds [100 x i8], [100 x i8]* %c, i64 0, i64 99, !dbg !84
  store i8 0, i8* %arrayidx, align 1, !dbg !85
  %3 = load i32, i32* %a, align 4, !dbg !86
  %4 = load i32, i32* %b, align 4, !dbg !87
  %arraydecay = getelementptr inbounds [100 x i8], [100 x i8]* %c, i64 0, i64 0, !dbg !88
  call void @fuzzMe(i32 %3, i32 %4, i8* %arraydecay), !dbg !89
  ret i32 0, !dbg !90
}

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #2

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.1 (https://github.com/llvm/llvm-project.git 75e33f71c2dae584b13a7d1186ae0a038ba98838)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "fuzzme.c", directory: "/home/klee/klee_src/examples/fuzzme")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 7, !"uwtable", i32 1}
!10 = !{i32 7, !"frame-pointer", i32 2}
!11 = !{!"clang version 13.0.1 (https://github.com/llvm/llvm-project.git 75e33f71c2dae584b13a7d1186ae0a038ba98838)"}
!12 = distinct !DISubprogram(name: "fuzzMe", scope: !1, file: !1, line: 7, type: !13, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!13 = !DISubroutineType(types: !14)
!14 = !{null, !15, !15, !4}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !12, file: !1, line: 7, type: !15)
!17 = !DILocation(line: 7, column: 17, scope: !12)
!18 = !DILocalVariable(name: "b", arg: 2, scope: !12, file: !1, line: 7, type: !15)
!19 = !DILocation(line: 7, column: 25, scope: !12)
!20 = !DILocalVariable(name: "c", arg: 3, scope: !12, file: !1, line: 7, type: !4)
!21 = !DILocation(line: 7, column: 36, scope: !12)
!22 = !DILocation(line: 8, column: 24, scope: !12)
!23 = !DILocation(line: 8, column: 27, scope: !12)
!24 = !DILocation(line: 8, column: 30, scope: !12)
!25 = !DILocation(line: 8, column: 5, scope: !12)
!26 = !DILocation(line: 9, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !12, file: !1, line: 9, column: 9)
!28 = !DILocation(line: 9, column: 11, scope: !27)
!29 = !DILocation(line: 9, column: 9, scope: !12)
!30 = !DILocation(line: 11, column: 17, scope: !31)
!31 = distinct !DILexicalBlock(scope: !32, file: !1, line: 11, column: 17)
!32 = distinct !DILexicalBlock(scope: !33, file: !1, line: 10, column: 28)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 10, column: 13)
!34 = distinct !DILexicalBlock(scope: !27, file: !1, line: 9, column: 21)
!35 = !DILocation(line: 11, column: 21, scope: !31)
!36 = !DILocation(line: 11, column: 19, scope: !31)
!37 = !DILocation(line: 11, column: 23, scope: !31)
!38 = !DILocation(line: 11, column: 17, scope: !32)
!39 = !DILocation(line: 12, column: 22, scope: !40)
!40 = distinct !DILexicalBlock(scope: !31, file: !1, line: 11, column: 30)
!41 = !DILocation(line: 12, column: 17, scope: !40)
!42 = !DILocalVariable(name: "s", scope: !40, file: !1, line: 13, type: !4)
!43 = !DILocation(line: 13, column: 23, scope: !40)
!44 = !DILocation(line: 13, column: 36, scope: !40)
!45 = !DILocation(line: 14, column: 24, scope: !40)
!46 = !DILocation(line: 14, column: 17, scope: !40)
!47 = !DILocation(line: 15, column: 30, scope: !40)
!48 = !DILocation(line: 15, column: 17, scope: !40)
!49 = !DILocation(line: 16, column: 13, scope: !40)
!50 = !DILocation(line: 17, column: 28, scope: !51)
!51 = distinct !DILexicalBlock(scope: !52, file: !1, line: 17, column: 21)
!52 = distinct !DILexicalBlock(scope: !31, file: !1, line: 16, column: 20)
!53 = !DILocation(line: 17, column: 21, scope: !51)
!54 = !DILocation(line: 17, column: 31, scope: !51)
!55 = !DILocation(line: 17, column: 21, scope: !52)
!56 = !DILocalVariable(name: "s", scope: !57, file: !1, line: 18, type: !4)
!57 = distinct !DILexicalBlock(scope: !51, file: !1, line: 17, column: 36)
!58 = !DILocation(line: 18, column: 27, scope: !57)
!59 = !DILocation(line: 18, column: 40, scope: !57)
!60 = !DILocation(line: 19, column: 28, scope: !57)
!61 = !DILocation(line: 19, column: 21, scope: !57)
!62 = !DILocation(line: 20, column: 35, scope: !57)
!63 = !DILocation(line: 20, column: 21, scope: !57)
!64 = !DILocation(line: 21, column: 17, scope: !57)
!65 = !DILocation(line: 25, column: 1, scope: !12)
!66 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 29, type: !67, scopeLine: 29, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!67 = !DISubroutineType(types: !68)
!68 = !{!15}
!69 = !DILocalVariable(name: "a", scope: !66, file: !1, line: 30, type: !15)
!70 = !DILocation(line: 30, column: 9, scope: !66)
!71 = !DILocalVariable(name: "b", scope: !66, file: !1, line: 30, type: !15)
!72 = !DILocation(line: 30, column: 12, scope: !66)
!73 = !DILocalVariable(name: "c", scope: !66, file: !1, line: 31, type: !74)
!74 = !DICompositeType(tag: DW_TAG_array_type, baseType: !5, size: 800, elements: !75)
!75 = !{!76}
!76 = !DISubrange(count: 100)
!77 = !DILocation(line: 31, column: 10, scope: !66)
!78 = !DILocation(line: 33, column: 24, scope: !66)
!79 = !DILocation(line: 33, column: 5, scope: !66)
!80 = !DILocation(line: 34, column: 24, scope: !66)
!81 = !DILocation(line: 34, column: 5, scope: !66)
!82 = !DILocation(line: 35, column: 24, scope: !66)
!83 = !DILocation(line: 35, column: 5, scope: !66)
!84 = !DILocation(line: 36, column: 5, scope: !66)
!85 = !DILocation(line: 36, column: 17, scope: !66)
!86 = !DILocation(line: 38, column: 12, scope: !66)
!87 = !DILocation(line: 38, column: 15, scope: !66)
!88 = !DILocation(line: 38, column: 18, scope: !66)
!89 = !DILocation(line: 38, column: 5, scope: !66)
!90 = !DILocation(line: 40, column: 5, scope: !66)
