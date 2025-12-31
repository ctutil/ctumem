'From Cuis7.2 [latest update: #6897] on 31 December 2025 at 10:57:44 am'!
'Description '!
!provides: 'CtuMem' 1 47!
!requires: 'FFI' 1 55 nil!
SystemOrganization addCategory: #CtuMem!


!classDefinition: #CtuMem category: #CtuMem!
Object subclass: #CtuMem
	instanceVariableNames: 'cMem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CtuMem'!
!classDefinition: 'CtuMem class' category: #CtuMem!
CtuMem class
	instanceVariableNames: ''!

!classDefinition: #CtuMemTest category: #CtuMem!
TestCase subclass: #CtuMemTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CtuMem'!
!classDefinition: 'CtuMemTest class' category: #CtuMem!
CtuMemTest class
	instanceVariableNames: ''!


!CtuMem methodsFor: 'public' stamp: 'ct 10/28/2025 15:38:25'!
add: aString
	self extAdd: cMem string: aString.! !

!CtuMem methodsFor: 'public' stamp: 'ct 10/28/2025 15:41:04'!
check
	^self extCheck: cMem.! !

!CtuMem methodsFor: 'public' stamp: 'ct 10/28/2025 15:39:44'!
free
	self extFree: cMem.! !

!CtuMem methodsFor: 'public' stamp: 'ct 10/28/2025 17:03:10'!
getArray
	^self extGetArray: cMem.! !

!CtuMem methodsFor: 'public' stamp: 'ct 12/28/2025 11:03:41'!
getAt: i
	" Gets the i-th element of the array. Warning: This follows the Smalltalk way: index starts from 1,
	   while in extGet: at: index follows the C way which starts from 0 "
	(i <= 0) ifTrue: [
		^self error: 'Invalid index: ', (i asString).
	].
	
	^self extGet: cMem at: i - 1.! !

!CtuMem methodsFor: 'public' stamp: 'ct 12/23/2025 10:07:46'!
getOffset
	^self extGetOffset: cMem.! !

!CtuMem methodsFor: 'public' stamp: 'ct 12/23/2025 10:07:34'!
getSize
	^self extGetSize: cMem.! !

!CtuMem methodsFor: 'public' stamp: 'ct 12/23/2025 09:42:37'!
getSizeWithoutLast
	^(self extGetSize: cMem) - 1.! !

!CtuMem methodsFor: 'external' stamp: 'ct 10/28/2025 15:42:27'!
extAdd: aCMem string: aString
	<cdecl: int32 'ctu_mem_add' (void* char*) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 10/28/2025 15:43:12'!
extCheck: aCMem
	<cdecl: int32 'ctu_mem_check' (void*) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 10/28/2025 15:43:56'!
extFree: aCMem
	<cdecl: void 'ctu_mem_free' (void*) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 10/28/2025 15:53:37'!
extGet: aCMem at: i
	<cdecl: void* 'ctu_mem_get' (void* int32) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 10/28/2025 15:35:35'!
extGetArray: aCMem
	<cdecl: void* 'ctu_mem_getArray' (void*) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 12/23/2025 10:03:39'!
extGetOffset: aCMem
	<cdecl: int32 'ctu_mem_getOffset' (void*) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 12/23/2025 10:03:33'!
extGetSize: aCMem
	<cdecl: int32 'ctu_mem_getSize' (void*) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'external' stamp: 'ct 12/21/2025 23:11:29'!
extInit: initialSize
	<cdecl: void* 'ctu_mem_init' (int32) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'initialization' stamp: 'ct 12/23/2025 09:43:37'!
with: aSize
	cMem := self extInit: aSize.! !

!CtuMem class methodsFor: 'constants' stamp: 'ct 10/28/2025 16:02:50'!
MAX_STR_LEN
	^2000.! !

!CtuMem class methodsFor: 'constants' stamp: 'ct 10/28/2025 15:55:42'!
RESULT_ERROR
	^-2.! !

!CtuMem class methodsFor: 'constants' stamp: 'ct 10/28/2025 15:55:50'!
RESULT_ERROR_CAPACITY
	^-3.! !

!CtuMem class methodsFor: 'constants' stamp: 'ct 10/28/2025 15:55:29'!
RESULT_SUCCESS
	^0.! !

!CtuMem class methodsFor: 'instance creation' stamp: 'ct 12/20/2025 23:17:08'!
initWith: aLength
	
	^self new with: aLength; yourself.
	! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 10/28/2025 15:57:16'!
testCapacityError
	| ctuMem |

	ctuMem := CtuMem initWith: 2.

	ctuMem add: 'Hello'.

	self assert: (ctuMem check) equals: CtuMem RESULT_ERROR_CAPACITY.

	ctuMem free.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 12/27/2025 10:36:31'!
testExternal
	| cmem ctuMem |

	ctuMem := CtuMem new.
	cmem := ctuMem extInit: 2.

	ctuMem extAdd: cmem string: 'Hello'.
	ctuMem extAdd: cmem string: 'world'.

	self assert: (ctuMem extGet: cmem at: 0) fromCString equals: 'Hello'.
	self assert: (ctuMem extGet: cmem at: 1) fromCString equals: 'world'.

	ctuMem extFree: cmem.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 12/27/2025 10:59:03'!
testGetAt
	| ctuMem |

	ctuMem := CtuMem initWith: 3.

	ctuMem add: 'Hello'.
	ctuMem add: 'world'.
	ctuMem add: nil.

	self assert: ((ctuMem getAt: 2) fromCString) equals: 'world'.

	ctuMem free.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 12/28/2025 12:28:06'!
testGetAt_invalid
	| ctuMem err |

	ctuMem := CtuMem initWith: 3.

	ctuMem add: 'Hello'.
	ctuMem add: 'world'.
	ctuMem add: nil.

	err := self should: [ ctuMem getAt: 0 ]
			raise: Error.

	ctuMem free.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 12/23/2025 10:10:38'!
testGetOffset
	| ctuMem |

	ctuMem := CtuMem initWith: 6.

	ctuMem add: 'Hello'.
	ctuMem add: 'world'.

	self assert: (ctuMem getOffset) equals: 2.

	ctuMem free.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 12/23/2025 10:09:58'!
testGetSize
	| ctuMem |

	ctuMem := CtuMem initWith: 3.

	ctuMem add: 'Hello'.
	ctuMem add: 'world'.
	ctuMem add: nil.

	self assert: (ctuMem getSize) equals: 3.

	ctuMem free.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 12/21/2025 23:13:09'!
testSizeWithoutLast
	| ctuMem |

	ctuMem := CtuMem initWith: 3.

	ctuMem add: 'Hello'.
	ctuMem add: 'world'.
	ctuMem add: nil.

	self assert: (ctuMem getSizeWithoutLast) equals: 2.

	ctuMem free.! !
