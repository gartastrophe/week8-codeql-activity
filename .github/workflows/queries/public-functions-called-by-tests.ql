/**
 * @description Find all public functions called by tests
 * @kind problem
 * @id javascript/public-functions-called-by-tests
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is a test.
 */
predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

/**
 * Holds if the given function is a public method of a class.
 */
predicate isPublicMethod(Function func) {
  exists(MethodDefinition md | 
    md.isPublic() and 
    md.getBody() = func
  )
}

/**
* Holds if `caller` contains a call to `callee`.
*/
predicate calls(Function caller, Function callee) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = caller and
    call.getACallee() = callee
  )
}



from Function test, Function callee, Function func
where isTest(test) and
      isPublicMethod(func) and
      calls(test, callee)
select callee, "is directly called by a test"