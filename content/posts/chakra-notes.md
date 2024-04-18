+++
title = 'Chakra UI Notes'
date = 2023-12-07
+++

## Chakra Notes

### Grid

- `templateColumns`: divide into columns, using `repeat(6, 1fr)` mean that seperate 6 columns
- `colSpan`: range from 1..max-number-column

```html
<Grid templateColumns="repeat(6, 1fr)" bg="gray.100">
  <GridItem
    as="aside"
    colSpan={{ base: 6, lg: 2, xl: 1 }}
    bg="brand.500"
    minHeight={{ lg: "100vh" }}
    p={{ base: "20px", lg: "30px" }}
  >
    <Slidebar />
  </GridItem>
  <GridItem as="main" colSpan={{ base: 6, lg: 2, xl: 5 }} p="30px">
    <Navbar />
    <Outlet />
  </GridItem>
</Grid>
```

## Table

```javascript
import {
  TableContainer,
  Table,
  Thead,
  Tbody,
  Tfoot,
  Tr,
  Th,
  Td,
} from "@chakra-ui/react";
```

```jsx
function JiraListControl({ onTagChange, onTagDelete }) {
  const data = useContext(DataTagContext);
  return (
    <TableContainer>
      <Table variant="simple">
        <Thead>
          <Tr>
            <Th w="25%">Tag name</Th>
            <Th w="60%">Jira Query</Th>
            <Th>Jira Count</Th>
            <Th>Edit Control</Th>
          </Tr>
        </Thead>
        <Tbody>
          {data.map((tag) => (
            <TagRow
              tag={tag}
              onTagChange={onTagChange}
              onTagDelete={onTagDelete}
              key={tag.id}
            />
          ))}
        </Tbody>
        <Tfoot>
          <Tr>
            <Th w="25%"></Th>
          </Tr>
        </Tfoot>
      </Table>
    </TableContainer>
  );
}

function TagRow({ tag, onTagChange, onTagDelete }) {
  const [isEditing, setIsEditing] = useState(false);

  const [tagName, setTagName] = useState(tag.tagName);
  const [tagQuery, setTagQuery] = useState(tag.tagQuery);

  function handleEditTag() {
    if (isEditing) {
      tag.tagName = tagName;
      tag.tagQuery = tagQuery;
      onTagChange(tag);
    }

    setIsEditing(!isEditing);
  }

  return (
    <Tr>
      {isEditing && (
        <Td>
          <Input
            type="text"
            value={tagName}
            onChange={(e) => setTagName(e.target.value)}
          />
        </Td>
      )}

      {!isEditing && (
        <Td>
          <Box
            bg="green"
            p={1}
            borderRadius="md"
            color="white"
            textAlign="center"
          >
            {tagName}
          </Box>
        </Td>
      )}

      {isEditing && (
        <Td>
          <Input
            type="text"
            value={tagQuery}
            onChange={(e) => setTagQuery(e.target.value)}
          />
        </Td>
      )}
      {!isEditing && <Td>{tagQuery}</Td>}

      {/* <Td>{tag.count}</Td> */}
      <Td>
        {tag.count == "..." && <Spinner color="green" />}
        {tag.count == "ERROR" && <Text color="tomato">{tag.count}</Text>}
        {tag.count != "ERROR" && tag.count != "..." && <Text>{tag.count}</Text>}
      </Td>
      <Td>
        <HStack spacing="4">
          <IconButton
            size="sm"
            icon={!isEditing ? <EditIcon /> : <CheckIcon />}
            onClick={() => handleEditTag(tag)}
          />
          <IconButton
            size="sm"
            icon={<DeleteIcon />}
            onClick={() => onTagDelete(tag.id)}
          />
        </HStack>
      </Td>
    </Tr>
  );
}
```

### Box

- `textAlign`: align text item in the box
- `maxW` = max width of box, using when want to limit width of box

```html
<Box textAlign="right" maxW="sm">
  <Text>{jiraRow.assignee}</Text>
</Box>
```

### HStack

- Hozirontal stack
- `spacing`: distance of items in `HStack`

```html
<HStack spacing="10px"> </HStack>
```

### Conditional rendering

- `{...some mixed}`

```jsx
{
  !isEditing && (
    <Td>
      <Box bg="green" p={1} borderRadius="md" color="white" textAlign="center">
        {tagName}
      </Box>
    </Td>
  );
}

{
  isEditing && (
    <Td>
      <Input
        type="text"
        value={tagQuery}
        onChange={(e) => setTagQuery(e.target.value)}
      />
    </Td>
  );
}
{
  !isEditing && <Td>{tagQuery}</Td>;
}
```

### Changing icon

```jsx
<IconButton
  size="sm"
  icon={!isEditing ? <EditIcon /> : <CheckIcon />}
  onClick={() => handleEditTag(tag)}
/>
```

### Common properties:

- `maxW`: max width
- `m`, `mt`...: margin
-
