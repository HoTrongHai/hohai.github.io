+++
title = 'React Re-Render'
date = 2023-12-05
+++

## React Re-render

There are 2 common cases that we want to re-render

- Top Bottom
- Bottom up

### Top Bottom

- The common cases: data from `current` to `child`
- Triggers:
  - Any change in `current` states (in `setXXX` method)
  - Any change in props

```jsx
function ParentComponent() {
  return (
    <div>
      <ChildComponent />
    </div>
  );
}

function Component() {
  {
    /*Internal state */
  }
  const [myState, setMyState] = useState(0);
  return (
    <div>
      <p>{"Number: " + myState.toString()}</p>

      {/* Any change of myState (is set by setMyState) will be trigger re-render */}
      <button onClick={() => setMyState(myState + 1)}>Click me</button>
    </div>
  );
}
```

```jsx
function ParentComponent() {
  const [countParent, setCountParent] = useState(0);
  const fromParent = "Count from Parent: " + countParent;
  return (
    <div>
      <Component prefixText={fromParent} />

      <button onClick={() => setCountParent(countParent + 1)}>
        Click me Parent
      </button>
    </div>
  );
}

function Component({ prefixText }) {
  {
    /*Internal state */
  }
  const [myState, setMyState] = useState(0);
  return (
    <div>
      <p>{prefixText}</p>
      <p>{"Count from Child: " + myState.toString()}</p>

      {/* Any change of myState (is set by setMyState) will be trigger re-render */}
      <button onClick={() => setMyState(myState + 1)}>Click me Child</button>
    </div>
  );
}
```

### Bottom Top

- Use `callback` approach to raise event

```jsx
function JiraEditableTextField({ children, jiraRow, jiraField, onReRender }) {
  function handleEdit() {
    if (editting) {
      jiraRow[jiraField] = fieldValue;
      /* Create new object to notify the setter (setReRende) know this is a change */
      onReRender({ render: true });
    }

    setEditting(!editting);
  }

  const [editting, setEditting] = useState(false);
  const [fieldValue, setFieldValue] = useState(jiraRow[jiraField]);
  if (editting) {
    return (
      <HStack>
        <Input
          type="text"
          value={fieldValue}
          onChange={(e) => setFieldValue(e.target.value)}
        ></Input>
        <IconButton size="sm" icon={<CheckIcon />} onClick={handleEdit} />
      </HStack>
    );
  } else {
    return (
      <HStack>
        {children}
        <IconButton size="sm" icon={<EditIcon />} onClick={handleEdit} />
      </HStack>
    );
  }
}

function JiraCell({ jiraRow }) {
  const [reRender, setReRender] = useState({ render: false });

  return (
    <Card maxW="sm">
      <CardHeader>
        <Grid templateColumns="repeat(4, 1fr)">
          <GridItem mr={2}>
            <StatusColorDisplay status={jiraRow.status} />
          </GridItem>

          <GridItem colSpan={2}>
            <Link href={jiraRow.link}>
              <Heading as="h3" size="sm">
                {jiraRow.key}
              </Heading>
            </Link>
            <Text>{jiraRow.assignee}</Text>
          </GridItem>
          <GridItem>
            <Text>Due Date</Text>
            <Text>{"N/A" || jiraRow.duedate}</Text>
          </GridItem>
        </Grid>
      </CardHeader>

      <CardBody>
        <JiraEditableTextField
          jiraRow={jiraRow}
          jiraField="summary"
          reRender={reRender}
          onReRender={setReRender}
        >
          <Text size="sm" noOfLines={3}>
            {jiraRow.summary}
          </Text>
        </JiraEditableTextField>
      </CardBody>
      <CardFooter>
        <TagNameDisplay
          tagNameList={jiraRow.tagNameList}
          tagColor="green"
          textColor="white"
        />
      </CardFooter>
    </Card>
  );
}
```
