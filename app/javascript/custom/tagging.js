function initializeTagInputs() {
	console.log('HELLO')
	const hiddenTagList = document.getElementById('hidden-tag-list')
	const tagData = hiddenTagList?.getAttribute('value')
	const tagsInput = document.getElementById('article_tags')
	const tagList = document.getElementById('tag-list')

	let tags = []
	if (tagData) tags = tagData.split(' ')
	console.log('TAGS', tags)
	if (tags.length > 0) createTag()

	function updateHiddenTagList() {
		document.getElementById('hidden-tag-list').value = tags.join(',')
	}

	function removeTag(element, tag) {
		let index = tags.indexOf(tag)
		tags.splice(index, 1)
		element.remove()
		console.log(tags)
		updateHiddenTagList()
	}

	function addTag(e) {
		console.log(e.key)
		if (['Enter', ' ', ','].includes(e.key)) {
			e.preventDefault()
			let inputTags = e.target.value.split(',').map((tag) => tag.trim().toLowerCase()) // 小文字化とトリミング
			inputTags.forEach((tag) => {
				if (tag.length > 1 && !tags.includes(tag)) {
					if (tags.length < 5) {
						tags.push(tag)
					}
				}
			})
			createTag()
			e.target.value = ''
			console.log(tags)
		}
	}

	function createTag() {
		tagList.innerHTML = ''
		tags.forEach((tag) => {
			let spanTag = document.createElement('span')
			spanTag.className = 'tag-default tag-pill'

			let closeIcon = document.createElement('i')
			closeIcon.className = 'ion-close-round'
			closeIcon.addEventListener('click', function () {
				removeTag(spanTag, tag)
			})

			spanTag.appendChild(closeIcon)

			let textNode = document.createTextNode(tag)
			spanTag.appendChild(textNode)

			tagList.appendChild(spanTag)
		})
		updateHiddenTagList()
	}

	tagsInput?.addEventListener('keydown', addTag)
}

document.addEventListener('turbo:load', initializeTagInputs)