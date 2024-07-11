//
//  DataHelper.swift
//  BookBucket
//
//  Created by Joshua Root on 3/25/24.
//

import CoreData

class DataService {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func insertBook(title: String, isFavorite: Bool, bookFormat: String, isbn: String, releaseDate: Date, numberOfPages: Int16, numberOfChapters: Int16, numberOfPagesRead: Int16, numberOfChaptersRead: Int16, isReading: Bool, isCompleted: Bool, coverImage: Data?) throws {
        let book = Book(context: context)
        book.id = UUID()
        book.title = title
        book.bookFormat = bookFormat
        book.releaseDate = releaseDate
        book.isbn = isbn
        book.isFavorite = isFavorite
        book.isReading = isReading
        book.isCompleted = isCompleted
        book.numberOfPages = numberOfPages
        book.numberOfChapters = numberOfChapters
        book.numberOfPagesRead = numberOfPagesRead
        book.numberOfChaptersRead = numberOfChaptersRead
        book.coverImage = coverImage
    
        do {
            try save()
        } catch {
            throw BookBucketDataError.insertError
        }
    }
    
    func update(book: Book, title: String, isFavorite: Bool, bookFormat: String, isbn: String, releaseDate: Date, numberOfPages: Int16, numberOfChapters: Int16, numberOfPagesRead: Int16, numberOfChaptersRead: Int16, isReading: Bool, isCompleted: Bool, coverImage: Data?) throws {
        book.title = title
        book.bookFormat = bookFormat
        book.releaseDate = releaseDate
        book.isbn = isbn
        book.isFavorite = isFavorite
        book.isReading = isReading
        book.isCompleted = isCompleted
        book.numberOfPages = numberOfPages
        book.numberOfChapters = numberOfChapters
        book.numberOfPagesRead = numberOfPagesRead
        book.numberOfChaptersRead = numberOfChaptersRead
        book.coverImage = coverImage
    
        do {
            try save()
        } catch {
            throw BookBucketDataError.saveError
        }
    }
    
    func insertAuthor(name: String, isFavorite: Bool) throws {
        let author = Author(context: context)
        author.id = UUID()
        author.name = name
        author.isFavorited = isFavorite
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.insertError
        }
    }
    
    func update(author: Author, name: String, isFavorite: Bool) throws {
        author.name = name
        author.isFavorited = isFavorite
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.saveError
        }
    }
    
    func insertGenre(name: String, isFavorite: Bool) throws {
        let genre = Genre(context: context)
        genre.id = UUID()
        genre.name = name
        genre.isFavorite = isFavorite
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.insertError
        }
    }
    
    func update(genre: Genre, name: String, isFavorite: Bool) throws {
        genre.name = name
        genre.isFavorite = isFavorite
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.saveError
        }
    }
    
    func insertBookList(name: String, color: String, isFavorite: Bool) throws {
        let bookList = BookList(context: context)
        bookList.id = UUID()
        bookList.name = name
        bookList.color = color
        bookList.isFavorite = isFavorite
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.insertError
        }
    }
    
    func update(bookList: BookList, name: String, color: String, isFavorite: Bool) throws {
        bookList.name = name
        bookList.color = color
        bookList.isFavorite = isFavorite
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.saveError
        }
    }
    
    func save() throws {
        do {
            try context.save()
        } catch {
            throw BookBucketDataError.saveError
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) throws {
        context.delete(object)
        do {
            try save()
        } catch {
            throw BookBucketDataError.deleteError
        }
    }
    
    func insert(book: Book, into list: BookList) throws {
        list.addToBooks(book)
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.addBookToListError
        }
    }
    
    func add(author: Author, to book: Book) throws {
        book.addToAuthors(author)
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.addAuthorToBookError
        }
    }
    
    func add(genre: Genre, to book: Book) throws {
        book.addToGenres(genre)
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.addGenreToBookError
        }
    }
    
    func remove(book: Book, from list: BookList) throws {
        list.removeFromBooks(book)
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.removeBookFromListError
        }
    }
    
    func remove(author: Author, from book: Book) throws {
        book.removeFromAuthors(author)
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.removeAuthorFromBookError
        }
    }
    
    func remove(genre: Genre, from book: Book) throws {
        book.removeFromGenres(genre)
        
        do {
            try save()
        } catch {
            throw BookBucketDataError.removeGenreFromBookError
        }
    }
}
