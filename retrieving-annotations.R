#' ---
#' title: "Retrieving annotation information in BIOM format"
#' author: ""
#' date: ""
#' ---

#' The function `biomRequest()` retrieves annotation data
#' as a `biom` object.  Metagenome and/or project IDs should be specified, for instance:

#+ eval=FALSE
biomRequest ("mgp9")
biomRequest ("mgm4441619.3 mgm4441620.3 mgm4441656.4")

#' When IDs are listed in a file (one per line) use the syntax:  `biomRequest(file="...")`.
#' Additionally, the file may contain metadata, which will be attached to the `biom` object,
#' provided a header line names the metadata fields, and the same fields appear on every line.
#' Values should be tab-separated.
#' Try the command `demoSets()`.  It shows where (in your local matR installation) to find
#' several demonstration ID files that can serve as models.

#+ eval=FALSE
demoSets()

#' Various options modify what data is retrieved by `biomRequest()`.
#' Scroll to the bottom of this page for a comprehensive list.
#' Just below, the first two examples retrieve functional annotations (the default)
#' at different levels of the Subsystems hierarchy.
#' After that follows a request for taxonomic annotations limited to a specific database.

#+ warning=FALSE, message=FALSE, results="hide"
ff <- demoSets()
xx <- biomRequest (file=ff[1], group_level="level1")
yy <- biomRequest (file=ff[1], group_level="level3")
zz <- biomRequest (file=ff[4], request="organism", group_level="phylum", source="Greengenes")

#+ results="markup"
summary (xx)
summary (yy)
summary (zz)

#' Private data requires an authorization key.
#' Log in at [http://metagenomics.anl.gov](http://metagenomics.anl.gov) and 
#' create a key via **Preferences** on the **Account Management** page.
#' _You must click not only **generate new key** but also **set preferences**_.
#' Then use one of these forms to tell your key to matR,
#' while heeding the warnings if data security is a concern for you:

#+ eval=FALSE
auth.MGRAST()						# this prompts for your key (and is safest).
auth.MGRAST("key goes here")		# whether in a line like this in a script file...
auth.MGRAST(file="my_key.txt")		# or in a file by itself... don't share your key accidentally.

#' A few caveats:  Downloads can require upwards of several hours to complete, so please be patient.
#' Also, the current code has not been stress-tested for very large retrievals.
#' Asynchronous requests and blocking are two mechanisms to help with possible problems, 
#' but they do not interact well with each other and are unsupported for now.
#' However, these examples should give the idea for users who wish to experiment:

#+ eval=FALSE
temp <- biomRequest ("mgp9", wait=FALSE)	# returns immediately (without data)
# ...do some other work for a while...
yy <- biom (temp, wait=FALSE)				# use this to test for data,
yy <- biom (temp)							# or this to wait

#+ eval=FALSE
biomRequest (file=ff[3], block=5)			# requests metagenomes in blocks of five

#' Setting R's timeout threshold for internet operations may also help in case of trouble.
#' For this, see `?options` and search for `"timeout"`.
#'
#' Retrieved annotation data can be directed to a file.  Then later, it can be brought into R
#' or analyzed with other software that uses BIOM format.
#' The syntax `biom(file="...")` shown just below can be used to load BIOM data
#' produced by other software into R, too.

#+ eval=FALSE
biomRequest ("mgp9", outfile="mgp9.biom")
biom (file="mgp9.biom")

#' There are many ways to modify what data is retrieved,
#' and it's not possible to discuss them all in detail here.
#' However, a complete list of options is available as shown below.
#' These commands dig into the internals of matR, so the output is a bit ... ugly.
#' But simply put, the list of options is displayed along with allowed values and meaning of each,
#' first for functional annotations, and then for taxonomic annotations.

doc.MGRAST (3, head=c("matrix","function","parameters","options"))
doc.MGRAST (3, head=c("matrix","organism","parameters","options"))

#' A separate tutorial discussing these options further is being developed.
