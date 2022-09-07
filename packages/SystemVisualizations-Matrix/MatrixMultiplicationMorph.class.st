Class {
	#name : #MatrixMultiplicationMorph,
	#superclass : #Morph,
	#instVars : [
		'left',
		'top',
		'result',
		'strategy',
		'slider',
		'playButton',
		'stateSlider',
		'stepsPerSecond',
		'blockSize'
	],
	#category : #'SystemVisualizations-Matrix'
}

{
	#category : #documentation,
	#'squeak_changestamp' : 'ct 9/7/2022 13:15'
}
MatrixMultiplicationMorph class >> example [

	(MatrixMultiplicationMorph rows: 10 columns: 9 length: 8) openInHand.
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'ct 9/5/2022 10:49'
}
MatrixMultiplicationMorph class >> rows: rows columns: columns length: length [

	^ self new
		rows: rows columns: columns length: length;
		yourself
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 19:00'
}
MatrixMultiplicationMorph >> acceptBlockSizeString: aStringOrText [

	self blockSize: aStringOrText asNumber.
	^ true
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:25'
}
MatrixMultiplicationMorph >> acceptColumnsString: aStringOrText [

	self columns: aStringOrText asNumber.
	^ true
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:27'
}
MatrixMultiplicationMorph >> acceptLengthString: aStringOrText [

	self length: aStringOrText asNumber.
	^ true
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:25'
}
MatrixMultiplicationMorph >> acceptRowsString: aStringOrText [

	self rows: aStringOrText asNumber.
	^ true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:12'
}
MatrixMultiplicationMorph >> allStrategyTypes [

	^ #(naive outer block)
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 10:40'
}
MatrixMultiplicationMorph >> backgroundColor [

	^ Color veryDarkGray
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 19:00'
}
MatrixMultiplicationMorph >> blockSize [

	^ blockSize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 19:02'
}
MatrixMultiplicationMorph >> blockSize: anInteger [

	blockSize := anInteger.
	
	self changed: #blockSizeString.
	(strategy respondsTo: #blockSize:) ifTrue:
		[strategy blockSize: blockSize].
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 19:01'
}
MatrixMultiplicationMorph >> blockSizeString [

	^ self blockSize asString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:01'
}
MatrixMultiplicationMorph >> columns [

	^ result columns
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:21'
}
MatrixMultiplicationMorph >> columns: anInteger [

	self rows: self rows columns: anInteger length: self length.
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:22'
}
MatrixMultiplicationMorph >> columnsString [

	^ self columns asString
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:00'
}
MatrixMultiplicationMorph >> defaultExtent [

	^ 600 px @ 600 px
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:15'
}
MatrixMultiplicationMorph >> doStrategy: aStrategy [

	strategy ifNotNil: [strategy terminate].
	
	strategy := aStrategy.
	
	strategy updateMorph.
	self updateState; startStepping.
	playButton setSwitchState: true.
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 19:02'
}
MatrixMultiplicationMorph >> initialize [

	super initialize.
	
	self extent: self defaultExtent.
	
	self stepsPerSecond: 1.
	
	self color: self backgroundColor.
	
	left := MatrixMorph new color: Color yellow.
	top := MatrixMorph new color: Color yellow.
	result := MatrixMorph new color: Color blue.
	
	self changeProportionalLayout.
	self
		addMorph: self newControlPane fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 0.5 @ 0.5) offsets: (10 px @ 10 px corner: -10 px @ -10 px));
		addMorph: left fullFrame: (LayoutFrame fractions: (0 @ 0.5 corner: 0.5 @ 1) offsets: (10 px @ 10 px corner: -10 px @ -10 px));
		addMorph: top fullFrame: (LayoutFrame fractions: (0.5 @ 0 corner: 1 @ 0.5) offsets: (10 px @ 10 px corner: -10 px @ -10 px));
		addMorph: result fullFrame: (LayoutFrame fractions: (0.5 @ 0.5 corner: 1 @ 1) offsets: (10 px @ 10 px corner: -10 px @ -10 px)).
	
	self rows: 0 columns: 0 length: 0.
	self blockSize: 4.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:52'
}
MatrixMultiplicationMorph >> leftMatrix [

	^ left
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:01'
}
MatrixMultiplicationMorph >> length [

	^ left columns
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:22'
}
MatrixMultiplicationMorph >> length: anInteger [

	self rows: self rows columns: self columns length: anInteger.
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:27'
}
MatrixMultiplicationMorph >> lengthString [

	^ self length asString
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:15'
}
MatrixMultiplicationMorph >> maxStateIndex [

	^ strategy numberOfStates
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 19:00'
}
MatrixMultiplicationMorph >> newBlockSizePane [

	^ self newRow
		addMorphBack: ((PluggableTextMorph on: self text: #blockSizeString accept: #acceptBlockSizeString:)
			balloonText: 'block size';
			hResizing: #spaceFill;
			vResizing: #rigid;
			height: ToolBuilder default inputFieldHeight;
			yourself);
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:59'
}
MatrixMultiplicationMorph >> newControlPane [

	^ Morph new
		beTransparent;
		changeTableLayout;
		cellGap: 5 px;
		addMorphBack: self newPauseButton;
		addMorphBack: self newSpeedSlider;
		addMorphBack:
			(self newRow
				addMorphBack: self newStrategySelector;
				addMorphBack: self newStateSlider;
				yourself);
		addMorphBack: self newDimensionsPane;
		addMorphBack: self newSpacer;
		addMorphBack: self newBlockSizePane;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:27'
}
MatrixMultiplicationMorph >> newDimensionsPane [

	^ self newRow
		addMorphBack: ((PluggableTextMorph on: self text: #rowsString accept: #acceptRowsString:)
			balloonText: 'rows';
			hResizing: #spaceFill;
			vResizing: #rigid;
			height: ToolBuilder default inputFieldHeight;
			yourself);
		addMorphBack: ((PluggableTextMorph on: self text: #columnsString accept: #acceptColumnsString:)
			balloonText: 'columns';
			hResizing: #spaceFill;
			vResizing: #rigid;
			height: ToolBuilder default inputFieldHeight;
			yourself);
		addMorphBack: ((PluggableTextMorph on: self text: #lengthString accept: #acceptLengthString:)
			balloonText: 'length';
			hResizing: #spaceFill;
			vResizing: #rigid;
			height: ToolBuilder default inputFieldHeight;
			yourself);
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 11:43'
}
MatrixMultiplicationMorph >> newPauseButton [

	^ playButton := SimpleSwitchMorph new
		label: 'play';
		target: self;
		actionSelector: #togglePlay;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:27'
}
MatrixMultiplicationMorph >> newRow [

	^ Morph new
		beTransparent;
		changeTableLayout;
		cellGap: 5 px;
		listDirection: #leftToRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 12:14'
}
MatrixMultiplicationMorph >> newSlider [

	^ Slider new
		orientation: #horizontal;
		height: 15 px;
		model: self;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:59'
}
MatrixMultiplicationMorph >> newSpacer [

	^ self newRow
		minimumHeight: 15 px;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 17:30'
}
MatrixMultiplicationMorph >> newSpeedSlider [

	^ self newSlider
		getValueSelector: #stepsPerSecond;
		setValueSelector: #stepsPerSecond:;
		minimumValue: 1;
		maximumValue: 100;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:15'
}
MatrixMultiplicationMorph >> newStateSlider [

	^ self newSlider
		getValueSelector: #stateIndex;
		setValueSelector: #stateIndex:;
		minimumValue: 1;
		getMaximumValueSelector: #maxStateIndex;
		yourself
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:13'
}
MatrixMultiplicationMorph >> newStrategySelector [

	^ DropDownChoiceMorph new
		target: self;
		color: Color white;
		contents: 'select strategy';
		getItemsSelector: #allStrategyTypes;
		actionSelector: #startStrategyType:;
		width: 150 px;
		hResizing: #rigid;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:52'
}
MatrixMultiplicationMorph >> resultMatrix [

	^ result
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:01'
}
MatrixMultiplicationMorph >> rows [

	^ result rows
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:21'
}
MatrixMultiplicationMorph >> rows: anInteger [

	self rows: anInteger columns: self columns length: self length.
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'ct 9/5/2022 18:27'
}
MatrixMultiplicationMorph >> rows: rows columns: columns length: length [

	left rows: rows columns: length.
	top rows: length columns: columns.
	result rows: rows columns: columns.
	
	self changed: #rowsString; changed: #columnsString; changed: #lengthString.
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 18:20'
}
MatrixMultiplicationMorph >> rowsString [

	^ self rows asString
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 19:01'
}
MatrixMultiplicationMorph >> startStrategyType: type [

	^ self doStrategy: (type caseOf:
		{[#naive] -> [MatrixNaiveMultiplicationStrategy for: self].
		[#outer] -> [MatrixOuterMultiplicationStrategy for: self].
		[#block] -> [(MatrixBlockMultiplicationStrategy for: self) blockSize: self blockSize]})
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:23'
}
MatrixMultiplicationMorph >> stateIndex [

	^ (strategy ifNotNil: [strategy stateIndex]) ifNil: [0]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 18:22'
}
MatrixMultiplicationMorph >> stateIndex: anInteger [

	strategy ifNotNil: [strategy gotoState: anInteger].
	self updateState.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'ct 9/5/2022 18:08'
}
MatrixMultiplicationMorph >> step [

	strategy ifNil: [^ self stopStepping].
	
	strategy advance; updateMorph.
	self updateState.
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'ct 9/5/2022 12:15'
}
MatrixMultiplicationMorph >> stepTime [

	^ 1000 / self stepsPerSecond
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:15'
}
MatrixMultiplicationMorph >> stepsPerSecond [

	^ stepsPerSecond
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 12:16'
}
MatrixMultiplicationMorph >> stepsPerSecond: aNumber [

	stepsPerSecond := aNumber.
	self changed: #stepsPerSecond.
]

{
	#category : #controls,
	#'squeak_changestamp' : 'ct 9/5/2022 11:48'
}
MatrixMultiplicationMorph >> togglePlay [

	self isStepping
		ifFalse: [self startStepping]
		ifTrue: [self stopStepping].
	playButton setSwitchState: self isStepping.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ct 9/5/2022 11:52'
}
MatrixMultiplicationMorph >> topMatrix [

	^ top
]

{
	#category : #updating,
	#'squeak_changestamp' : 'ct 9/5/2022 18:23'
}
MatrixMultiplicationMorph >> updateState [

	self changed: #maxStateIndex; changed: #stateIndex.
	
	strategy ifNil: [^ self].
	strategy terminated ifTrue:
		[strategy reset].
]
