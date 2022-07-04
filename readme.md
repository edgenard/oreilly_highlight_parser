# Parsing O'Reilly Books Exported Highlights to Markdown

[O'Reilly Books](https://learning.oreilly.com/home/) allows you to export the highlights and notes made while reading a book, but those highlights are exported in the CSV file format. The highlights are also in reverse chronological order, meaning the latest ones are at the top and the earliest ones at the bottom of the CSV file.

The goal of this parser is to take in the exported highlights for an individual book and parse it into a markdown file.


## Specification

The CSV exported from O'Reilly is formatted like this:

| Book Title | Chapter Title | Date of Highlight | Book URL | Chapter URL | Annotation URL | Highlight | Personal Note |
|------------|---------------|-------------------|----------|-------------|----------------|-----------|---------------|
| Title | Chapter 1 | YYYY-MM-DD | https://example.com | https://example.com  | https://example.com | Text that was highlighted | Any notes made about the text |


With the last highlight made at the beginning and the first highlight made at the bottom.

Given:
- A CSV file formatted like the one above
- For 1 book(so the Book Title value is exactly the same for all highlights)
- With highlights in reverse chronological order

Return a markdown file:
- Whose file name is the book title in snake case(`book_title`)
- And formatted like the example below, with the oldest highlight first


```md
# [Book Title Notes](book_url)

## [Chapter](chapter_url)

[Highlight](annotation_url)
Personal Note

```


