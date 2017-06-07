require_relative '../models/address_book.rb'

RSpec.describe AddressBook do
  let(:book) { AddressBook.new }

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

  describe "attributes" do

    it "responds to entries" do
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expect(book.entries.size).to eq(1)
    end
    it "adds the correct information to entries" do
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       new_entry = book.entries[0]

       check_entry(new_entry, 'Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
     end
  end

  describe "#remove_entry" do
    it "removes the correct entry from address book using name,phone_number, and email" do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Boba Fett', '123.456.7890', 'fake_boba@hotmail.com')
      book.add_entry('Boba Fett', '098.765.4321', 'fett_man@bounty.com')

      expect(book.entries.size).to eq(3)

      book.remove_entry('Boba Fett', '123.456.7890', 'fake_boba@hotmail.com')
      entry_one = book.entries[0]
      entry_two = book.entries[1]

      expect(book.entries.size).to eq(2)
      check_entry(entry_one, 'Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      check_entry(entry_two, 'Boba Fett', '098.765.4321', 'fett_man@bounty.com')
    end
  end

  describe "#import_from_csv import from entry.csv" do

    it "imports the correct number of entries" do
      book.import_from_csv("entries.csv")
      book_size = book.entries.size

      expect(book_size).to eq 5
    end

    it "imports the 1st entry" do
       book.import_from_csv("entries.csv")
       entry_one = book.entries[0]
       # Check the first entry
       check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
     end
     it "imports the 2nd entry" do
       book.import_from_csv("entries.csv")
       # Check the second entry
       entry_two = book.entries[1]
       check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv("entries.csv")
       # Check the third entry
       entry_three = book.entries[2]
       check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "imports the 4th entry" do
       book.import_from_csv("entries.csv")
       # Check the fourth entry
       entry_four = book.entries[3]
       check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "imports the 5th entry" do
       book.import_from_csv("entries.csv")
       # Check the fifth entry
       entry_five = book.entries[4]
       check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end
  end

  describe "#import_from_csv import from entry_2.csv" do

    it "imports the correct number of entries" do
      book.import_from_csv("entries_2.csv")
      book_size = book.entries.size

      expect(book_size).to eq 3
    end

    it "imports the 1st entry" do
       book.import_from_csv("entries_2.csv")
       entry_one = book.entries[0]
       # Check the first entry
       check_entry(entry_one, "Chas", "555.555.3333", "not_a_perm@hotmail.com")
    end
     it "imports the 2nd entry" do
       book.import_from_csv("entries_2.csv")
       # Check the second entry
       entry_two = book.entries[1]
       check_entry(entry_two, "Margot", "555.555.2222", "too_much_eyeliner@hotmail.com")
    end

     it "imports the 3rd entry" do
       book.import_from_csv("entries_2.csv")
       # Check the third entry
       entry_three = book.entries[2]
       check_entry(entry_three, "Richie", "555.555.1111", "the_t_bomb@hotmail.com")
    end
  end

  describe "#binary_search" do

    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bob")
      expect(entry).to be_a Entry
      check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
    end

    it "searches AddressBook for Joe" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Joe")
      expect(entry).to be_a Entry
      check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
    end

    it "searches AddressBook for Sally" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sally")
      expect(entry).to be_a Entry
      check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
    end

    it "searches AddressBook for Sussie" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Sussie")
      expect(entry).to be_a Entry
      check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
    end

    it "searches AddressBook for Billy" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Billy")
      expect(entry).to be_nil
    end
  end
end
