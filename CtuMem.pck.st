'From Cuis7.2 [latest update: #6897] on 28 October 2025 at 4:03:12 pm'!
'Description '!
!provides: 'CtuMem' 1 27!
!requires: 'FFI' 1 55 nil!
SystemOrganization addCategory: #CtuMem!


!classDefinition: #CtuMem category: #CtuMem!
Object subclass: #CtuMem
	instanceVariableNames: 'cMem size'
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

!CtuMem methodsFor: 'public' stamp: 'ct 10/28/2025 15:45:13'!
getArray
	self extGetArray: cMem.! !

!CtuMem methodsFor: 'public' stamp: 'ct 10/28/2025 15:40:44'!
getAt: i
	^self extGet: cMem at: i.! !

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

!CtuMem methodsFor: 'external' stamp: 'ct 10/28/2025 15:35:26'!
extInit: initialSize
	<cdecl: void* 'ctu_mem_init' (int32) module: 'ctumem'>
	^self externalCallFailed
! !

!CtuMem methodsFor: 'initialization' stamp: 'ct 10/28/2025 15:46:52'!
with: aSize
	size := aSize.
	cMem := self extInit: size.! !

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

!CtuMem class methodsFor: 'instance creation' stamp: 'ct 10/27/2025 14:53:22'!
initWith: aSize
	
	^self new with: aSize; yourself.
	! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 10/28/2025 15:57:16'!
testCapacityError
	| ctuMem |

	ctuMem := CtuMem initWith: 2.

	ctuMem add: 'Hello'.

	self assert: (ctuMem check) equals: CtuMem RESULT_ERROR_CAPACITY.

	ctuMem free.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 10/27/2025 12:22:32'!
testExternal
	| cmem ctuMem |

	ctuMem := CtuMem new.
	cmem := ctuMem extInit: 2.

	ctuMem extAdd: cmem string: 'Hello'.
	ctuMem extAdd: cmem string: 'world'.

	self assert: (ctuMem extGet: cmem at: 0) fromCString equals: 'Hello'.
	self assert: (ctuMem extGet: cmem at: 1) fromCString equals: 'world'.

	ctuMem extFree: cmem.! !

!CtuMemTest methodsFor: 'cases' stamp: 'ct 10/28/2025 15:52:38'!
testPublic
	| ctuMem |

	ctuMem := CtuMem initWith: 2.

	ctuMem add: 'Hello'.
	ctuMem add: 'world'.

	self assert: (ctuMem getAt: 0) fromCString equals: 'Hello'.
	self assert: (ctuMem getAt: 1) fromCString equals: 'world'.

	ctuMem free.! !
